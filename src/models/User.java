package models;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

interface Profile { 
	public String username = "";
	public String firstname = "";
	public String lastname = "";
	public Integer tweets = null;
	public Integer followers = null;
	public Integer following = null;
	public Boolean isVerified = null;
}

public class User implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Integer uid = null;
	private String username = "";
	private String firstname = "";
	private String lastname = "";
	private String hashedPassword = "";
	private String salt = "";
	private String mail = "";
	private String birth = "";
	private Integer tweets = null;
	private Integer followers = null;
	private Integer following = null;
	private Boolean isVerified = null;
	private Boolean isAdmin = null;
	
	//no sabem si treure-ho
	private String pwd1 = "";
	private String pwd2 = "";
	
	
	private boolean[] error = { false, false, false, false, false, false };

	public User() {

	}

	public Integer getUid(){
		return this.uid;
	}
	
	public void setUid(Integer uid) {
		this.uid = uid;
	}


	public String getMail() {
		return this.mail;
	}

	public void setMail(String mail) {
		String regex = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(mail);
		if (matcher.matches()) {
			this.mail = mail;
			// System.out.println(mail);
		} else {
			error[2] = true;
			// System.out.println(mail);
		}

	}

	public String getPwd1() {
		return this.pwd1;
	}

	public void setPwd1(String pwd1) {

		if (pwd1.length() >= 8) {
			String regex = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{8,}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(pwd1);
			if (matcher.matches()) {
				System.out.println(pwd1);
				this.pwd1 = pwd1;
				// System.out.println(mail);
			} else {
				error[3] = true;
				// System.out.println(mail);
			}
		} else {
			error[3] = true;
		}
	}

	public String getPwd2() {
		return this.pwd2;
	}

	public void setPwd2(String pwd2) {
		/* TODO check restriction with pattern and check if pwd1=pwd2 */
		if (pwd2.length() >= 8) {
			String regex = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{8,}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(pwd2);
			if (matcher.matches()) {
				if (this.pwd1.equals(pwd2)) {
					this.pwd2 = pwd2;
				}
			} else {
				error[4] = true;
				// System.out.println(mail);
			}
		} else {
			error[4] = true;
		}
	}

	public String getBirth() {
		return this.birth;  //TODO: maybe store birth as date not string. better for UTC
	}

	
	public void setBirth(String birth) {
		System.out.println(birth);
		DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate fechaNac = LocalDate.parse(birth, fmt);
		LocalDate ahora = LocalDate.now();

		Period periodo = Period.between(fechaNac, ahora);
		System.out.printf("Tu edad es: %s anos, %s meses y %s dias", periodo.getYears(), periodo.getMonths(),
				periodo.getDays());
		if (periodo.getYears() >= 16) {
			this.birth = birth;
		} else {
			error[5] = true; // Es menor de 16 anys.
		}

	}

	public boolean[] getError() {
		return error;
	}

	public void setError(int i, boolean state) {
		error[i] = state;
	}

	public void userExists() {
		this.username = "";
		this.mail = "";
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		if (username.length() > 20) {
			// La longitud es major a la permesa.
			error[1] = true;
		} else {
			// Comprovem que el username no contingui caracters invalids.
			String regex = "^[a-zA-Z0-9_]+$"; // Conte nomes numeros, lletres i guions baixos.
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(username);
			if (matcher.matches()) {
				this.username = username;
			} else {
				// Conte caracters especials no valids.
				error[1] = true;
			}
		}
	}

	public String getFirstname() {
		return this.firstname;
	}
	
	public void setFirstname(String firstname) {
		if (firstname.length() > 50) {
			// La longitud es major a la permesa.
			error[0] = true;
		} else {
			// Comprovem que el nom no contingui caracters invalids.
			String regex = "^[a-zA-Z0-9_ ]+$"; // Conte nomes numeros, lletres i guions baixos.
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(firstname);
			if (matcher.matches()) {
				this.firstname = firstname;
			} else {
				// Conte caracters especials no valids.
				error[0] = true;
			}
		}
	}


	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String lastname) {
		if (lastname.length() > 50) {
			// La longitud es major a la permesa.
			error[0] = true;
		} else {
			// Comprovem que el nom no contingui caracters invalids.
			String regex = "^[a-zA-Z0-9_ ]+$"; // Conte nomes numeros, lletres i guions baixos.
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(lastname);
			if (matcher.matches()) {
				this.lastname = lastname;
			} else {
				// Conte caracters especials no valids.
				error[0] = true;
			}
		}
	}

	public String getHashedPassword() {
		return hashedPassword;
	}

	public void setHashedPassword(String hashedPassword) {
		this.hashedPassword = hashedPassword;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public Integer getTweets() {
		return this.tweets;
	}

	public void setTweets(Integer tweets) {
		this.tweets = tweets;
	}


	public Integer getFollowers() {
		return followers;
	}

	public void setFollowers(Integer followers) {
		this.followers = followers;
	}


	public Integer getFollowing() {
		return following;
	}

	public void setFollowing(Integer following) {
		this.following = following;
	}

	public Boolean getIsVerified() {
		return isVerified;
	}

	public void setIsVerified(Boolean isVerified) {
		this.isVerified = isVerified;
	}
	
	public Boolean getIsAdmin() {
		return isAdmin;
	}
	
	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	

}
