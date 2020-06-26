package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class changeSessionVar
 * 
 * Servlet util per cambiar variables en sessio (mantenir la vista on es troba el usuari al recarregar la pagina).
 * 
 */
@WebServlet("/changeSessionVar")
public class changeSessionVar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public changeSessionVar() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if(session != null) {
			//Mode 1 --> Cambiar la variable de sessio setVar per una de sessio. Util per assignar userview a user.
			if(Integer.parseInt(request.getParameter("mode")) == 1) {
				session.setAttribute(request.getParameter("setVar"), session.getAttribute(request.getParameter("getVar")));
			}else {
			//Mode 2 --> Cambiar la variable de sessio setVar per una de request.
				session.setAttribute(request.getParameter("setVar"), request.getParameter("getVar"));
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
