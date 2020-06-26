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
 * 
 * Editar dades personals.
 * 
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
		/*Parametres que rebem per request*/
		String username = request.getParameter("username");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String birth = request.getParameter("birth");
		/**/
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		HttpSession session = request.getSession(false);
		boolean isAdmin = ((User)session.getAttribute("user")).getIsAdmin(); //Saber si l'usuari loggejat es admin. Podra editar tots els perfils.
		boolean isLoggedUser = false;
		
		/*Saber si es tracta del edit d'un usuari loggejat (podra eliminar el seu perfil)*/
		if(((User)session.getAttribute("user")).getUid() == ((User)session.getAttribute("viewuser")).getUid()) {
			isLoggedUser = true;
		}
		
		request.setAttribute("isAdmin", isAdmin);
		request.setAttribute("isLoggedUser", isLoggedUser);
		
		ManageUser userManager = new ManageUser();
		User user = null;
		
		try {
			user = userManager.getUser(uid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/*Si hi ha algun parametre que no esta buit vol dir que l'usuari ha modificat algun camp.*/
		if((username != "" && username != null) || (firstname != "" && firstname != null)|| (lastname != "" && lastname != null) || (birth != "" && birth != null)) {
			
			user.setUsername(username);
			user.setFirstname(firstname);
			user.setLastname(lastname);
			user.setBirth(birth);

			userManager.editUser(uid, username, firstname, lastname, birth);
		}
		
		/*Setejem els nous parametres.*/
		request.setAttribute("username", user.getUsername());
		request.setAttribute("firstname", user.getFirstname());
		request.setAttribute("lastname", user.getLastname());
		request.setAttribute("uid", user.getUid());
		request.setAttribute("birth",user.getBirth());
		/**/
		
		userManager.finalize();
		
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
