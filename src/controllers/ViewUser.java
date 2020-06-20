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
 * Servlet implementation class ViewUser
 */
@WebServlet("/ViewUser")
public class ViewUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Hii from view user"+request.getParameter("viewusername"));
		String viewusername = request.getParameter("viewusername").replace(" ", "");
		
		HttpSession session = request.getSession(false);
		User user = (User)session.getAttribute("user");
		System.out.println(user.getUsername());
		String content = "";
		if(viewusername.equals(user.getUsername())) {
			System.out.println("Same user");
			content = "ViewLoginDone.jsp";
		}else {
			ManageUser userManager = new ManageUser();
			User viewuser = null;
			try {
				viewuser = userManager.getUser(viewusername);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.setAttribute("viewuser", viewuser);
			content = "ProfileUserView.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(content);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
