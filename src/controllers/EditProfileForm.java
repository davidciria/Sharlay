package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import managers.ManageUser;
import models.User;

/**
 * Servlet implementation class EditProfileForm
 */
@WebServlet("/EditProfileForm")
public class EditProfileForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfileForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(new Integer(request.getParameter("firstTime")) != 1) {
			HttpSession session = request.getSession(false);
			int uid = (int)session.getAttribute("uid");
			
			if(request.getParameter("username") != "") {
				System.out.println(request.getParameter("username"));
			}
			if(request.getParameter("firstname") != "") {
				System.out.println(request.getParameter("firstname"));
			}
			if(request.getParameter("lastname") != ""){
				System.out.println(request.getParameter("lastname"));
			}
			
			User user = (User) session.getAttribute("user");
			
			user.setUsername(request.getParameter("username"));
			user.setFirstname(request.getParameter("firstname"));
			user.setLastname(request.getParameter("lastname"));
			
			session.setAttribute("user", user);
			
			ManageUser userManager = new ManageUser();
			userManager.editUser(uid, request.getParameter("username"), request.getParameter("firstname"), request.getParameter("lastname"));
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("EditProfileForm.jsp");
	    if (dispatcher != null) dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
