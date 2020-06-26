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
 * 
 * Servlet per mostrar la vista dun usuari.
 * 
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
		
		String viewusername = null;
		
		viewusername = request.getParameter("viewusername").replace(" ", "");
		
		HttpSession session = request.getSession(false);
		User user;
		String cview = "";
		ManageUser userManager = new ManageUser();
		
		if(session != null) {
			//Usuari loggejat.
			user = (User)session.getAttribute("user");
			//Volem veure el perfil de lusuari loggejat.
			if(viewusername.equals(user.getUsername())) {
				session.setAttribute("viewuser", user);
				cview = "ViewLoginDone.jsp";
			}else {
			//Volem veure el perfil dun altre usuari (no es el loggejat).
				User viewuser = null;
				Boolean isFollowed = null;
				try {
					viewuser = userManager.getUser(viewusername);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					isFollowed = userManager.userIsFollowed(user.getUid(), viewuser.getUid());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				session.setAttribute("viewuser", viewuser);
				session.setAttribute("isFollowed", isFollowed);
				cview = "ProfileUserView.jsp";
			}

		} else {
			//Usuari anonymous.
			try {
				request.setAttribute("viewuser", userManager.getUser(viewusername));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			cview = "ProfileUserViewFromAnonymouse.jsp";
		}
		
		userManager.finalize();
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(cview);
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
