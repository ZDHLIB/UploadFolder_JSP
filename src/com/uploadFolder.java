package com;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class uploadFolder extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public uploadFolder() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/plain");
		PrintWriter outNet = response.getWriter();

		int id = Integer.parseInt(request.getParameter("id"));
		String filePath = java.net.URLDecoder.decode(request
				.getParameter("path"), "UTF-8");
		String fileName = filePath.substring(filePath.lastIndexOf("\\") + 1);
		String loadPath = "E:\\JAVA\\ProgramFiles\\LRC\\uploadedFiles"; // 将要上传到的路径。
		InputStream in = request.getInputStream();
		BufferedInputStream bis = new BufferedInputStream(in);
		File file = new File(loadPath);
		if (!file.exists()) {
			file.mkdir();
		}
		BufferedOutputStream bos = new BufferedOutputStream(
				new FileOutputStream(new File(loadPath + fileName)));
		int b = 0;
		while ((b = bis.read()) != -1) {
			bos.write(b);
			bos.flush();
		}
		bis.close();
		bos.close();
		in.close();
		System.out.println("文件上传成功");

	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
