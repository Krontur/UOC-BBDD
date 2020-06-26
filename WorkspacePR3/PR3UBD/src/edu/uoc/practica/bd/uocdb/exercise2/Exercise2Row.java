package edu.uoc.practica.bd.uocdb.exercise2;

public class Exercise2Row {

	private String nationality;
	private String genre;
	private int numMovies;
	private int maxAwards;
	private int totalDuration;

	public Exercise2Row(String nationality, String genre, int numMovies,int maxAwards, int totalDuration) {
		super();
		this.setNationality(nationality);
		this.setGenre(genre);
		this.setNumMovies(numMovies);
		this.setMaxAwards(maxAwards);
		this.setTotalDuration(totalDuration);
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public int getNumMovies() {
		return numMovies;
	}

	public void setNumMovies(int num_movies) {
		this.numMovies = num_movies;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public int getMaxAwards() {
		return maxAwards;
	}

	public void setMaxAwards(int maxAwards) {
		this.maxAwards = maxAwards;
	}

	public int getTotalDuration() {
		return totalDuration;
	}

	public void setTotalDuration(int totalDuration) {
		this.totalDuration = totalDuration;
	}
	
}