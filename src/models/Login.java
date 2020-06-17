package models;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Login {

	private String mail = "";
	private String pwd = "";
	private boolean[] error = {false, false};
	
	public String getMail(){
		return mail;
	}
	
	public void setMail(String mail){
		String regex = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(mail);
		if (matcher.matches()) {
			this.mail = mail;
			// System.out.println(mail);
		} else {
			error[0] = true;
			// System.out.println(mail);
		}
	}
	
	public String getPwd() {
		return pwd;
	}
	
	public void setPwd(String pwd) {
		if (pwd.length() >= 8) {
			String regex = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{8,}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(pwd);
			if (matcher.matches()) {
				System.out.println(pwd);
				this.pwd = pwd;
				// System.out.println(mail);
			} else {
				error[1] = true;
				// System.out.println(mail);
			}
		} else {
			error[1] = true;
		}
	}
	
	public void restartFields() {
		mail = "";
		pwd = "";
	}
	
	public boolean[] getError() {
		return error;
	}
	
	public boolean isComplete() {
	    return(hasValue(getMail()) && hasValue(getPwd()));
	}
	
	
	private boolean hasValue(String val) {
		return((val != null) && (!val.equals("")));
	}
	
}