package edu.uoc.practica.bd.uocdb.exercise1;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import edu.uoc.practica.bd.util.DBAccessor;
import edu.uoc.practica.bd.util.FileUtilities;

public class Exercise1InsertAndUpdateDataFromFile {
	private FileUtilities fileUtilities;

	public Exercise1InsertAndUpdateDataFromFile() {
		super();
		fileUtilities = new FileUtilities();

	}

	public static void main(String[] args) {
		Exercise1InsertAndUpdateDataFromFile app = new Exercise1InsertAndUpdateDataFromFile();
		app.run();
	}

	private void run() {
		
		List<List<String>> fileContents = null;
		
		try {
			fileContents = fileUtilities.readFileFromClasspath("exercise1.data");
		} catch (FileNotFoundException e) {
			System.err.println("ERROR: File not found");
			e.printStackTrace();
		} catch (IOException e) {
			System.err.println("ERROR: I/O error");
			e.printStackTrace();
		}
		if (fileContents == null) {
			return;
		}

		DBAccessor dbaccessor = new DBAccessor();
		dbaccessor.init();
		Connection conn = dbaccessor.getConnection();

		// TODO Prepare everything before updating or inserting
		if(conn != null) {
			
			PreparedStatement updateActorPreparedStatement = null;
			PreparedStatement updatePersonPreparedStatement = null;
			PreparedStatement insertActorPreparedStatement = null;
			PreparedStatement insertPersonPreparedStatement = null;
			
			try {
				
				String updateActorSql = "UPDATE ACTOR " + "SET debut_year = ? " + "WHERE id=?";
				String updatePersonSql = "UPDATE PERSON " + "SET name = ?, birth = ?, death = ?," + 
										 "gender = ?, nationality = ? " + "WHERE id=?";
				String insertActorSql = "INSERT INTO ACTOR" +"(id, debut_year) " + "VALUES(?, ?)";
				String insertPersonSql = "INSERT INTO PERSON " + "VALUES(?, ?, ?, ?, ?, ?)";
				
				updateActorPreparedStatement = conn.prepareStatement(updateActorSql);
				updatePersonPreparedStatement = conn.prepareStatement(updatePersonSql);
				insertActorPreparedStatement = conn.prepareStatement(insertActorSql);
				insertPersonPreparedStatement = conn.prepareStatement(insertPersonSql);
				
				// TODO Update or insert Actor and Participation from every row in file
				for (List<String> row : fileContents) {	
					
					int updatedActorSQL = 0; 
					int updatedPersonSQL = 0;
					
					updateActorPreparedStatement.clearParameters();
					setActorUpdatePreparedStatement(updateActorPreparedStatement, row);
					updatedActorSQL = updateActorPreparedStatement.executeUpdate();
					
					if(updatedActorSQL == 1) {
						updatePersonPreparedStatement.clearParameters();
						setPersonUpdatePreparedStatement(updatePersonPreparedStatement, row);
						updatedPersonSQL = updatePersonPreparedStatement.executeUpdate();
					} 
					
					if(updatedActorSQL == 0 && updatedPersonSQL == 0) {
						
						insertPersonPreparedStatement.clearParameters();
						setPersonInsertPreparedStatement(insertPersonPreparedStatement, row);
						insertPersonPreparedStatement.executeUpdate();
						
						insertActorPreparedStatement.clearParameters();
						setActorInsertPreparedStatement(insertActorPreparedStatement, row);
						insertActorPreparedStatement.executeUpdate();
					}	
				}
				// TODO Validate transaction
				conn.commit();
				
				// TODO Close resources and check exceptions
			} catch (SQLException e) {
				System.err.println("ERROR: Executing SQL Insert or Update Actor or Person");
				System.err.println(e.getMessage());
				try {
					System.out.println("Doing Rollback");
					conn.rollback();
				} catch (SQLException e2) {
					System.out.println("Message" + e2.getMessage());
					System.out.println("SQLState" + e2.getSQLState());
					System.out.println("ErrorCode" + e2.getErrorCode());
				}
			} finally {
				
				if(updateActorPreparedStatement != null) {
					try {
						updateActorPreparedStatement.close();
					} catch (SQLException e) {
						System.err.println("ERROR: Closing connection update");
						System.err.println(e.getMessage());
					}
				}
				
				if(updatePersonPreparedStatement != null) {
					try {
						updatePersonPreparedStatement.close();
					} catch (SQLException e) {
						System.err.println("ERROR: Closing connection update");
						System.err.println(e.getMessage());
					}
				}
				
				if(insertActorPreparedStatement != null) {
					try {
						insertActorPreparedStatement.close();
					} catch (SQLException e) {
						System.err.println("ERROR: Closing connection insert");
						System.err.println(e.getMessage());
					}
				}
				
				if(insertPersonPreparedStatement != null) {
					try {
						insertPersonPreparedStatement.close();
					} catch (SQLException e) {
						System.err.println("ERROR: Closing connection insert");
						System.err.println(e.getMessage());
					}
				}
				
				if(conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						System.err.println("ERROR: Closing connection database");
						System.err.println(e.getMessage());
					}
				}
			}
		}
	}

	private void setPersonUpdatePreparedStatement(PreparedStatement preparedStatement, List<String> row)
			throws SQLException {
		String[] rowArray = (String[]) row.toArray(new String[0]);

		setValueOrNull(preparedStatement, 1, getValueIfNotNull(rowArray, 2)); // name
		setValueOrNull(preparedStatement, 2, getDateFromString(getValueIfNotNull(rowArray, 3))); // birth
		setValueOrNull(preparedStatement, 3, getDateFromString(getValueIfNotNull(rowArray, 4))); // death
		setValueOrNull(preparedStatement, 4, getValueIfNotNull(rowArray, 5)); // gender
		setValueOrNull(preparedStatement, 5, getValueIfNotNull(rowArray, 6)); // nationality
		setValueOrNull(preparedStatement, 6, getIntegerFromStringOrNull(getValueIfNotNull(rowArray, 0))); // Id
	}

	private void setActorUpdatePreparedStatement(PreparedStatement preparedStatement, List<String> row)
			throws SQLException {
		String[] rowArray = (String[]) row.toArray(new String[0]);

		setValueOrNull(preparedStatement, 1, getIntegerFromStringOrNull(getValueIfNotNull(rowArray, 1))); // year
		setValueOrNull(preparedStatement, 2, getIntegerFromStringOrNull(getValueIfNotNull(rowArray, 0))); // Id
	}

	private void setPersonInsertPreparedStatement(PreparedStatement preparedStatement, List<String> row)
			throws SQLException {
		String[] rowArray = (String[]) row.toArray(new String[0]);

		setValueOrNull(preparedStatement, 1, getIntegerFromStringOrNull(getValueIfNotNull(rowArray, 0))); // Id
		setValueOrNull(preparedStatement, 2, getValueIfNotNull(rowArray, 2)); // name
		setValueOrNull(preparedStatement, 3, getDateFromString(getValueIfNotNull(rowArray, 3))); // birth
		setValueOrNull(preparedStatement, 4, getDateFromString(getValueIfNotNull(rowArray, 4))); // death
		setValueOrNull(preparedStatement, 5, getValueIfNotNull(rowArray, 5)); // gender
		setValueOrNull(preparedStatement, 6, getValueIfNotNull(rowArray, 6)); // nationality
	}

	private void setActorInsertPreparedStatement(PreparedStatement preparedStatement, List<String> row)
			throws SQLException {
		String[] rowArray = (String[]) row.toArray(new String[0]);

		setValueOrNull(preparedStatement, 1, getIntegerFromStringOrNull(getValueIfNotNull(rowArray, 0))); // Id
		setValueOrNull(preparedStatement, 2, getIntegerFromStringOrNull(getValueIfNotNull(rowArray, 1))); // year
	}

	private Integer getIntegerFromStringOrNull(String integer) {
		return (null != integer) ? Integer.valueOf(integer) : null;
	}

	private String getValueIfNotNull(String[] rowArray, int index) {
		String ret = null;
		if (index < rowArray.length) {
			ret = rowArray[index];
		}
		return ret;
	}

	private Date getDateFromString(String dateInString) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		try {
			if (dateInString != null)
				return formatter.parse(dateInString);
		} catch (ParseException e) {
		}
		return null;
	}

	private void setValueOrNull(PreparedStatement preparedStatement, int parameterIndex, Integer value)
			throws SQLException {
		if (value == null) {
			preparedStatement.setNull(parameterIndex, Types.INTEGER);
		} else {
			preparedStatement.setInt(parameterIndex, value);
		}
	}

	private void setValueOrNull(PreparedStatement preparedStatement, int parameterIndex, Date value)
			throws SQLException {
		if (value == null) {
			preparedStatement.setNull(parameterIndex, Types.DATE);
		} else {
			preparedStatement.setDate(parameterIndex, new java.sql.Date(value.getTime()));
		}
	}

	private void setValueOrNull(PreparedStatement preparedStatement, int parameterIndex, String value)
			throws SQLException {
		if (value == null || value.length() == 0) {
			preparedStatement.setNull(parameterIndex, Types.VARCHAR);
		} else {
			preparedStatement.setString(parameterIndex, value);
		}
	}

}
