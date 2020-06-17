package utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PwdHashGenerator {

	public static boolean checkPassword(String pwd, String pwdBase64, String saltBase64) {

		byte[] byteSalt = Base64.getDecoder().decode(saltBase64); // Decodificar base 64 a bytes.
		byte[] bytePwd = pwd.getBytes(StandardCharsets.UTF_8);
		if (generatePasswordSaltHash(bytePwd, byteSalt).equals(pwdBase64))
			return true;
		else
			return false;

	}

	public static String generatePasswordSaltHash(byte[] bytePwd, byte[] byteSalt) {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		byte[] bytePwdSalt = null;
		// Unir bytePwd i byteSalt.
		try {
			outputStream.write(bytePwd);
			outputStream.write(byteSalt);
			bytePwdSalt = outputStream.toByteArray();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/////////////////////////////////////

		// Generar hash sha256 i convertir a Base64//
		MessageDigest digest;
		try {
			digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(bytePwdSalt);
			String encoded = new String(Base64.getEncoder().encode(hash));
			return encoded; // En pwd hashejat sera convertit en una string base64 del pwd+salt (43 bytes).
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//////////////////////////////////////

		return null; // Hi ha hagut un error.
	}

	public static byte[] generateRandomSalt(int size) {
		if (size < 6 || size > 1024) {
			size = 6;
		}
		byte[] salt = new byte[size];
		SecureRandom random = new SecureRandom();
		random.nextBytes(salt);
		return salt;
	}

	public static String convertToBase64(byte[] array) {
		return new String(Base64.getEncoder().encode(array));
	}

}
