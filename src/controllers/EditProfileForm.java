package controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

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
		String username = request.getParameter("username");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		HttpSession session = request.getSession(false);
		boolean isAdmin = ((User)session.getAttribute("user")).getIsAdmin();
		boolean isLoggedUser = false;
		
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
		
		if((username != "" && username != null) || (firstname != "" && firstname != null)|| (lastname != "" && lastname != null)) {
			
			user.setUsername(username);
			user.setFirstname(firstname);
			user.setLastname(lastname);
			
			request.setAttribute("username", user.getUsername());
			request.setAttribute("firstname", user.getFirstname());
			request.setAttribute("lastname", user.getLastname());
			request.setAttribute("uid", user.getUid());

			userManager.editUser(uid, username, firstname, lastname);
			
			//Pujar imatge de perfil.
			processRequest(request,response);
			
			userManager.finalize();
		}
			
		if(Boolean.parseBoolean(request.getParameter("firstCall"))) {
				request.setAttribute("username", user.getUsername());
				request.setAttribute("firstname", user.getFirstname());
				request.setAttribute("lastname", user.getLastname());
				request.setAttribute("uid", user.getUid());
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
	
protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
		response.setContentType("text/html;charset=UTF-8");

	    // Create path components to save the file (you have to change this)
	    String path = "C://Users//david//eclipse-workspace//Sharlay//WebContent//ProfileImages";
		final Part filePart = request.getPart("file");
	    final String fileName = getFileName(filePart);

	    OutputStream out = null;
	    InputStream filecontent = null;
	    final PrintWriter writer = response.getWriter();

	    try {
	        out = new FileOutputStream(new File(path + File.separator
	                + fileName));
	        filecontent = filePart.getInputStream();

	        int read = 0;
	        final byte[] bytes = new byte[1024];

	        while ((read = filecontent.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        writer.println("New file " + fileName + " created at " + path);
	    } catch (FileNotFoundException fne) {
	        writer.println("You either did not specify a file to upload or are "
	                + "trying to upload a file to a protected or nonexistent "
	                + "location.");
	        writer.println("<br/> ERROR: " + fne.getMessage());
	    } finally {
	        if (out != null) {
	            out.close();
	        }
	        if (filecontent != null) {
	            filecontent.close();
	        }
	        if (writer != null) {
	            writer.close();
	        }
	    }
	    
	}

	private String getFileName(final Part part) {
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(
	                    content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}

}
