package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import managers.ManageUser;
import utils.VerificationEmailSender;

/**
 * Servlet implementation class VerificationEmailSenderController
 * 
 * Servlet per enviar email de verificacio.
 * 
 */
@WebServlet("/VerificationEmailSenderController")
public class VerificationEmailSenderController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VerificationEmailSenderController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String mail = request.getParameter("mail");
		String username = request.getParameter("username");
		
		ManageUser manager = new ManageUser();
		VerificationEmailSender verSender = new VerificationEmailSender();
		verSender.sendVerificationEmail(mail, manager.getUserID(mail), username);
		verSender.finalize();
		
		manager.finalize();
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
