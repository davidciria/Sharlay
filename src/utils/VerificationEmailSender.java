package utils;

import java.net.UnknownHostException;
import java.security.SecureRandom;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Base64;

public class VerificationEmailSender {

	private DAO db = null;
	private String verificationMsg = "Please confirm your email following this link: ";
	private String incorrectEmailMsg = "Please delete this email if you are not the reiciver";

	public VerificationEmailSender() {
		try {
			db = new DAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void sendVerificationEmail(String destEmail, Integer uid, String username) throws UnknownHostException {
		String token = this.generateVerificationToken();
		this.addTokenToUser(token, uid);
		EmailSender sender = new EmailSender();
		// String hostname = InetAddress.getLocalHost().getHostAddress();
		// System.out.println(sHostName);
		String hostname = "localhost";
		sender.sendEmail(destEmail, "Gaming Twitter Email Verification",
				verificationMsg + "http://" + hostname + ":8080/Lab_3/VerificationEmailController?email=" + destEmail
						+ "&token=" + token + " " + incorrectEmailMsg);
	}

	private void addTokenToUser(String token, Integer uid) {
		String query = "UPDATE Users SET token=?,regVerified=0 WHERE uid=?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, token);
			statement.setInt(2, uid);
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private String generateVerificationToken() {
		SecureRandom secureRandom = new SecureRandom(); // threadsafe
		Base64.Encoder base64Encoder = Base64.getUrlEncoder(); // threadsafeBase64.Encoder base64Encoder =
																// Base64.getUrlEncoder(); //threadsafe
		byte[] randomBytes = new byte[24];
		secureRandom.nextBytes(randomBytes);
		return base64Encoder.encodeToString(randomBytes);
	}

}
