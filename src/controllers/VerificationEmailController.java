package controllers;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.DAO;

/**
 * Servlet implementation class VerificationEmailController
 * 
 * Servlet que sexecuta quan usuari obre el link de verificacio.
 * 
 */
@WebServlet("/VerificationEmailController")
public class VerificationEmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private DAO db = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VerificationEmailController() {
		super();
		// TODO Auto-generated constructor stub
		try {
			db = new DAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void finalize() {
		try {
			super.finalize();
			db.disconnectBD();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("email") != null && request.getParameter("token") != null) {
			int verificationStatus = this.verifyEmailToken(request.getParameter("email"),
					request.getParameter("token"));
			if (verificationStatus != 0) {
				//Verificacio ha anat correctament.
				if(verificationStatus == 2) request.setAttribute("verified", 3);
				else request.setAttribute("verified", 1);
				request.setAttribute("menu","ViewMenuNotLogged.jsp");
				request.setAttribute("content","ViewLoginForm.jsp");
				RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
			    dispatcher.forward(request, response);
			} else {
				// Servlet error en la verificacio.
				request.setAttribute("verified", 2);
				request.setAttribute("menu","ViewMenuNotLogged.jsp");
				request.setAttribute("content","ViewLoginForm.jsp");
				RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
			    dispatcher.forward(request, response);
			}
		}
		
		this.finalize();
	}

	/*Aquesta part es pot posar al userManger*/
	private int verifyEmailToken(String email, String emailToken) {
		String query = "SELECT token, regVerified FROM Users WHERE mail=?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, email);
			ResultSet rs = statement.executeQuery();
			String dbToken = null;
			Boolean regVerified = false;
			
			if (rs.next()) {
				dbToken = rs.getString("token");
				regVerified = rs.getBoolean("regVerified");
				statement.close();
				// Comprovar que el token es correcte.
				if (dbToken.equals(emailToken) && !regVerified) {
					// Actualitzar verificated a true correctament.
					query = "UPDATE Users SET regVerified=1 WHERE mail=?";
					statement = null;
					statement = db.prepareStatement(query);
					statement.setString(1, email);
					statement.executeUpdate();
					statement.close();
					return 1;
				}else {
					return 2;
				}
			}

			return 0; // Hi ha hagut algun error.

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
