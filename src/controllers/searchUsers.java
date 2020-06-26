package controllers;

import java.io.IOException;
import java.util.List;

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
 * Servlet implementation class searchUsers
 * 
 * Servlet per fer una cerca dusuaris.
 * 
 */
@WebServlet("/searchUsers")
public class searchUsers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchUsers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ManageUser userManager = new ManageUser();
		HttpSession session = request.getSession(false);
		String cview = "";
		if(session != null) {
			//Usuari loggejat.
			int uid = (int)session.getAttribute("uid");
			cview = "searchResult.jsp";
			try {
				List<User> searchResult = userManager.searchUsers(request.getParameter("searchWords"));
				for(int i = 0; i < searchResult.size(); i++) {
					//Saber si els segueix lusuari loggejat.
					searchResult.get(i).setIsFollowed(userManager.userIsFollowed(uid, searchResult.get(i).getUid()));
				}
				request.setAttribute("searchResult", searchResult);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		else
		{
			//Usuari anonymous.
			cview = "searchResultFromAnonymous.jsp";
			try {
				List<User> searchResult = userManager.searchUsers(request.getParameter("searchWords"));
				request.setAttribute("searchResult", searchResult);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
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
