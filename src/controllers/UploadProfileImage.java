package controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


/**
 * Servlet implementation class FileUpload
 * 
 * Servlet per pujar una foto de perfil.
 * 
 */
@WebServlet("/UploadProfileImage")
@MultipartConfig
public class UploadProfileImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadProfileImage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Pujar la fotografia de perfil.
		processRequest(request,response);
		
		/*La fotografia segueix el seguent patro: {userid}.png */
		/*Daquesta manera no es necesari guardar el nom de la fotografia a la base de dades*/
		/*Si lusuari torna a pujar una nova fotografia de perfil es sobreescriu.*/
	    
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
	    String fileName = getFileName(filePart);
	    String[] splittedFileName = fileName.split(Pattern.quote("."));
	    
	    String fileFormat = splittedFileName[splittedFileName.length - 1];
	    
	    if(fileFormat.equals("png")) {
	    	fileName = request.getParameter("uid") + ".png"; /*La fotografia segueix el seguent patro: {userid}.png */
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
		        out.flush();
		        writer.println("success");
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
	    }else {
	    	final PrintWriter writer = response.getWriter();
	    	writer.println("fail");
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
