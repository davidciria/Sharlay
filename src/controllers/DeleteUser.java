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
 * Servlet implementation class DeleteUser
 * 
 * Eliminar un usuari de la base de dades.
 * 
 */
@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//Change to admin main view.
		HttpSession session = request.getSession(false);
		int uid = Integer.parseInt(request.getParameter("userToDeleteUid")); //Obtenir uid del usuari que volem eliminar.
		
		if(((User)session.getAttribute("user")).getUid() != ((User)session.getAttribute("viewuser")).getUid()) {
			/*Si el usuari es un administrador que esta eliminant un altre usuari.*/
			
			this.deleteUser(uid);
			
			session.setAttribute("viewuser", session.getAttribute("user"));
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("ViewLoginDone.jsp");
		    dispatcher.forward(request, response);
		}else {
			/*Si es un usuari personal.*/
			
			this.deleteUser(uid);
			
			if (session!=null) {
				session.invalidate();
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("viewDeletedAccount.jsp");
		    dispatcher.forward(request, response);
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void deleteUser(int uid) {
		ManageUser userManager = new ManageUser();
		
		userManager.deleteUser(uid);
		
		userManager.finalize();
	}

}
