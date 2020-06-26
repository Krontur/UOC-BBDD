package edu.uoc.practica.bd.uocdb.exercise2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import edu.uoc.practica.bd.util.Column;
import edu.uoc.practica.bd.util.DBAccessor;
import edu.uoc.practica.bd.util.Report;

public class Exercise2PrintReportOverQuery {
	public static void main(String[] args) {
		Exercise2PrintReportOverQuery app = new Exercise2PrintReportOverQuery();
		app.run();
	}

	private void run() {
		DBAccessor dbaccessor = new DBAccessor();
		dbaccessor.init();
		Connection conn = dbaccessor.getConnection();
		if (conn != null) {
			Statement stmnt = null;
			ResultSet resultSet = null;
			try {
				List<Column> columns = Arrays.asList(
						new Column("Nationality", 9, "nationality"),
						new Column("Genre", 10, "genre"),
						new Column("Num movies", 4, "numMovies"),
						new Column("Max awards", 12, "maxAwards"),
						new Column("Total duration", 13, "totalDuration"));

				Report report = new Report();
				report.setColumns(columns);
				List<Object> list = new ArrayList<Object>();

				// TODO Execute SQL sentence
				stmnt = conn.createStatement();
				resultSet = stmnt.executeQuery("SELECT * FROM REPORT_DIRECTORS_NATIONALITY " + 
												"ORDER BY num_movies DESC, max_awards DESC;");
					
				// TODO Loop over results and get the main values
				String nationality;
				String genre;
				int num_movies;
				int max_awards;
				int total_duration;
					
				while(resultSet.next()) {
					nationality = resultSet.getString(1);
					genre = resultSet.getString(2);
					num_movies = resultSet.getInt(3);
					max_awards = resultSet.getInt(4);
					total_duration = resultSet.getInt(5);
						
					Exercise2Row row = new Exercise2Row(nationality, genre, num_movies, max_awards, total_duration);
					list.add(row);
				}
				// TODO End loop
				if(list.isEmpty()) {
					System.out.println("List without data");
				} else {
					report.printReport(list);
				}
		
			} catch (SQLException e) {
				System.err.println("ERROR: List not avaible");
				System.err.println(e.getMessage());
			} finally {
				// TODO Close All resources
				if(resultSet != null) {
					try {
						resultSet.close();
					}catch (SQLException e) {
						System.err.println("ERROR: Closing resultSet");
						System.err.println(e.getMessage());
					}
				}
				
				if(stmnt != null) {
					try {
						stmnt.close();
					}catch (SQLException e) {
						System.err.println("ERROR: Closing Statement");
						System.err.println(e.getMessage());
					}
				}
				
				if(conn != null) {
					try {
						conn.close();
					}catch (SQLException e) {
						System.err.println("ERROR: Closing resultSet");
						System.err.println(e.getMessage());
					}
				}
			}				
		}
	}
}
