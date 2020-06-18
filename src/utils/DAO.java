package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DAO {

	private Connection connection = null;

	public DAO() throws Exception {

		// WITHOUT POOL
		String user = "mysql";
		String password = "prac";
		String hostname = "localhost";
		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		connection = DriverManager
				.getConnection("jdbc:mysql://" + hostname + "/ts1?user=" + user + "&password=" + password + "&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");

	}

	// execute queries

	public PreparedStatement prepareStatement(String query) throws SQLException {
		// Note that this is done using
		// https://www.arquitecturajava.com/jdbc-prepared-statement-y-su-manejo/
		return connection.prepareStatement(query);
	}

	public void disconnectBD() throws SQLException {
		connection.close();
	}
}