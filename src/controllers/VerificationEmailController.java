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

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("email") != null && request.getParameter("token") != null) {
			boolean verificationStatus = this.verifyEmailToken(request.getParameter("email"),
					request.getParameter("token"));
			if (verificationStatus) {
				//Verificacio ha anat correctament.
				request.setAttribute("verified", 1);
				RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
			    dispatcher.forward(request, response);
			} else {
				// Servlet error en la verificacio.
				request.setAttribute("verified", 2);
				RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
			    dispatcher.forward(request, response);
			}
		}
	}

	/*Aquesta part es pot posar al userManger*/
	private boolean verifyEmailToken(String email, String emailToken) {
		String query = "SELECT token FROM Users WHERE mail=?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, email);
			ResultSet rs = statement.executeQuery();
			String dbToken = null;

			if (rs.next()) {
				dbToken = rs.getString("token");
				statement.close();
				// Comprovar que el token es correcte.
				if (dbToken.equals(emailToken)) {
					// Actualitzar verificated a true correctament.
					query = "UPDATE Users SET regVerified=1 WHERE mail=?";
					statement = null;
					statement = db.prepareStatement(query);
					statement.setString(1, email);
					statement.executeUpdate();
					statement.close();
					System.out.println("User verified correctly");
					return true;
				}
			}

			return false; // Hi ha hagut algun error.

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
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
