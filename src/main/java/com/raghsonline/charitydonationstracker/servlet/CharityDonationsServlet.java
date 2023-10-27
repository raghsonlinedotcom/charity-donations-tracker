package com.raghsonline.charitydonationstracker.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


/**
 * Servlet implementation class LoginServlet
 */
@WebServlet({ "/CharityDonationsServlet" })
public class CharityDonationsServlet extends HttpServlet

{
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CharityDonationsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException
    {
        System.out.println("CharityDonationsServlet - doGet() invoked");

        request.getRequestDispatcher("/WEB-INF/views/charityDonations.jsp")
                .forward(request, response);
    }

}
