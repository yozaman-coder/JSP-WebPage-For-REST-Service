<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="provinces.Province" %>
<%@ page import="java.util.List" %>
<%!
	public void createProvinceAndStates()
	{

		try{

			// Get connection
			String user = "";
			String password = "";
			String url = "";
			FileInputStream fis = new FileInputStream("c:\\connection.properties");
			Properties p = new Properties();
			p.load(fis);
			url = (String) p.get("url");
			user = (String) p.get("user");
			password = (String) p.get("password");
			Class.forName("org.mariadb.jdbc.Driver");
			Connection dbConn = DriverManager.getConnection(url, user, password);

			String sql = "CREATE TABLE IF NOT EXISTS Provinces( ProvinceID INT NOT NULL AUTO_INCREMENT, ProvinceCode VARCHAR(32), ProvinceName VARCHAR(64), PRIMARY KEY(ProvinceID));";
			Statement stmt = dbConn.createStatement();
			stmt.execute(sql);

			sql = "CREATE TABLE IF NOT EXISTS States( StateID INT NOT NULL AUTO_INCREMENT, StateCode VARCHAR(32), StateName VARCHAR(64), PRIMARY KEY(StateID));";
			stmt = dbConn.createStatement();
			stmt.execute(sql);

			String sql2 = "SELECT * FROM Provinces WHERE ProvinceName='Alberta'";
			Statement stmt2 = dbConn.createStatement();
			ResultSet dataIsThere = stmt2.executeQuery(sql2);

			// If there is no provinces Insert states and provinces into db
			if(!dataIsThere.next())
			{
				sql =   "INSERT INTO States(StateCode, StateName) VALUES ('AL', 'Alabama')," +
						"('AK', 'Alaska')," +
						"('AZ', 'Arizona')," +
						"('AR', 'Arkansas')," +
						"('CA', 'California')," +
						"('CO', 'Colorado')," +
						"('CT', 'Connecticut')," +
						"('DE', 'Delaware')," +
						"('DC', 'District of Columbia')," +
						"('FL', 'Florida')," +
						"('GA', 'Georgia')," +
						"('HI', 'Hawaii')," +
						"('ID', 'Idaho')," +
						"('IL', 'Illinois')," +
						"('IN', 'Indiana')," +
						"('IA', 'Iowa')," +
						"('KS', 'Kansas')," +
						"('KY', 'Kentucky')," +
						"('LA', 'Louisiana')," +
						"('ME', 'Maine')," +
						"('MD', 'Maryland')," +
						"('MA', 'Massachusetts')," +
						"('MI', 'Michigan')," +
						"('MN', 'Minnesota')," +
						"('MS', 'Mississippi')," +
						"('MO', 'Missouri')," +
						"('MT', 'Montana')," +
						"('NE', 'Nebraska')," +
						"('NV', 'Nevada')," +
						"('NH', 'New Hampshire')," +
						"('NJ', 'New Jersey')," +
						"('NM', 'New Mexico')," +
						"('NY', 'New York')," +
						"('NC', 'North Carolina')," +
						"('ND', 'North Dakota')," +
						"('OH', 'Ohio')," +
						"('OK', 'Oklahoma')," +
						"('OR', 'Oregon')," +
						"('PA', 'Pennsylvania')," +
						"('RI', 'Rhode Island')," +
						"('SC', 'South Carolina')," +
						"('SD', 'South Dakota')," +
						"('TN', 'Tennessee')," +
						"('TX', 'Texas')," +
						"('UT', 'Utah')," +
						"('VT', 'Vermont')," +
						"('VA', 'Virginia')," +
						"('WA', 'Washington')," +
						"('WV', 'West Virginia')," +
						"('WI', 'Wisconsin')," +
						"('WY', 'Wyoming')";

				stmt = dbConn.createStatement();
				stmt.execute(sql);

				sql =   "INSERT INTO Provinces(ProvinceCode, ProvinceName) VALUES " +
						"('AB', 'Alberta')," +
						"('BC', 'British Columbia')," +
						"('MB', 'Manitoba')," +
						"('NB', 'New Brunswick')," +
						"('NL', 'Newfoundland and Labrador')," +
						"('NT', 'Northwest Territories')," +
						"('NS', 'Nova Scotia')," +
						"('NU', 'Nunavut')," +
						"('ON', 'Ontario')," +
						"('PE', 'Prince Edward Island')," +
						"('QC', 'Quebec')," +
						"('SK', 'Saskatchewan')," +
						"('YT', 'Yukon')";
				stmt = dbConn.createStatement();
				stmt.execute(sql);
			}

			dbConn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}




	}

	public String createCustomer(String [] customerArray)
		{
			String sql = "INSERT INTO customers ("
				+ "CustomerID, CustFirstName, CustLastName, CustAddress, CustCity, CustProv, CustCountry, CustPostal, CustHomePhone, CustBusPhone, CustEmail, AgentID"
			    + ") values (S_101_1_CUSTOMERS.NEXTVAL, "
				+ "'" + customerArray[0] + "'," 
				+ " '" + customerArray[1] + "',"
				+ " '" + customerArray[2] + "',"
				+ " '" + customerArray[3] + "',"
				+ " '" + customerArray[4] + "',"
				+ " '" + customerArray[5] + "',"
				+ " '" + customerArray[6] + "',"
				+ " '" + customerArray[7] + "',"
				+ " '" + customerArray[8] + "',"
				+ " '" + customerArray[9] + "',"
				+ " " + customerArray[10] + ")";


		    try
		    {
				// Get connection
				String user = "";
				String password = "";
				String url = "";
				FileInputStream fis = new FileInputStream("c:\\connection.properties");
				Properties p = new Properties();
				p.load(fis);
				url = (String) p.get("url");
				user = (String) p.get("user");
				password = (String) p.get("password");

				Class.forName("org.mariadb.jdbc.Driver");
				Connection dbConn = DriverManager.getConnection(url, user, password);

		        Statement stmt = dbConn.createStatement();

		        int rows = stmt.executeUpdate(sql);

		        // Cleanup
		        dbConn.close();  // close the connection
		        
				if (rows == 1)
				{
					return "Your registration was a success. Thank you for joining The Travel Experts.";
				}
				else
				{
					return "Insert was NOT succesful";
				}
		    }
		    catch (Exception excp)
		    {
		        excp.printStackTrace();
		    }
			return "";
		}
		
		public void displayForm(String [] customerArray, javax.servlet.jsp.JspWriter out) throws IOException
		{
			out.print("<form name='form1' method='get' action=''>");
			out.print("<table width='600' border='0' align='center' cellpadding='0' cellspacing='5'>");
			out.print("<tr>");
			out.print("<caption>Customer Registration</caption>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td colspan='2'><h6>Required fields indicated with a *</h6></td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td width='90'><div align='left'>*First Name:</div>");
			out.print("</td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustFirstName' type='text' id='CustFirstName' value='" + customerArray[0] + "'></div>"); 
			out.print("</td>");
			out.print("<td width='110'><div align='left'>*Last Name:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustLastName' type='text' id='CustLastName' value='" + customerArray[1] + "'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>&nbsp;</td><td>&nbsp;</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td><div align='left'>Address:</div></td>");
			out.print("<td colspan='2'><div align='left'>");
			out.print("<input name='CustAddress' type='text' id='CustAddress' value='" + customerArray[2] + "' maxlength='75' size='25'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td><div align='left'>*City:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustCity' type='text' id='Custcity' value='" + customerArray[3] + "'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>");
			out.print("<div align='left' id='label'>*Province:</div>");
			out.print("</td>");
			out.print("<td>");
			out.print("<div align='left' id='region'>");
			out.print("<select name='CustProv'  id='CustProv'>");
			out.print("<option value=''>Select One...</option>");
			out.print("</select>");
			out.print("</div>");
			out.print("</td>");
			out.print("<td><div align='left'>*Country:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<select name='CustCountry' id='CustCountry' onchange=changeRegion() >");
			out.print("<option value=''>Select One...</option>");
			out.print("<option value='Canada'>Canada</option>");
			out.print("<option value='United States'>United States</option>");
			out.print("</select>");
			out.print("</div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td><div align='left' id='zippostal'>*Postal Code:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustPostal' type='text' id='CustPostal' value='" + customerArray[6] + "'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>&nbsp;</td><td>&nbsp;</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td><div align='left'>*Home Phone:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustHomePhone' type='text' id='CustHomePhone' value='" + customerArray[7] + "'></div>");
			out.print("</td>");
			out.print("<td><div align='left'>Business Phone:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustBusPhone' type='text' id='CustBusPhone' value='" + customerArray[8] + "'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td><div align='left'>Email:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='CustEmail' type='text' id='CustEmail' value='" + customerArray[9] + "' size='25'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>&nbsp;</td><td>&nbsp;</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td><div align='left'>AgentID:</div></td>");
			out.print("<td><div align='left'>");
			out.print("<input name='AgentID' type='text' id='AgentID' value='" + customerArray[10] + "' size='25'></div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("<tr>");
			out.print("<td>&nbsp;</td><td>&nbsp;</td>");
			out.print("</tr>");
			out.print("</table>");
			out.print("<table width='200' border='0' align='center'>");
			out.print("<tr>");
			out.print("<td width='100'>");
			out.print("<input type='submit'  name='submit' value='Register'>");
			out.print("</td>");
			out.print("<td width='100'>");
			out.print("<div align='left'>");
			out.print("<input name='reset' type='reset' id='reset' value='Reset' />");
			out.print("</div>");
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
			out.print("</form>");
					
			out.print("<p><b>Privacy statement:</b> Any information entered in the above fields will be used for the purposes of Travel Experts alone. We will not share your information with anyone</p>");
			out.print("<p>&nbsp;</p>");
			out.print("<p>&nbsp;</p>");			
		}
		
		public String validate(String [] customerData)
		{
			for (int i=0; i<customerData.length; i++)
			{
				if (customerData[i].equals(""))
				{
					switch(i)
					{
						case 0:
							return "**First name must have a value!**";
						
						case 1:
							return "**Last name must have a value!**";
						
						case 2:
							break;						
						
						case 3:
							return "**You must include your city name!**";
							
						case 4:
							return "**You must include your province or state name!**";
							
						case 5:
							return "**You must include your country name!**";
							
						case 6:
							return "**You must include your postal or zip code!**";
							
						case 7:
							return "**Please provide your home phone number!**";
							
						case 8:
							break;
							
						case 9:

							break;
						
						default:
						return "field must have a value.";
					}
				}
			}
			return "";
		}
		
%>

<jsp:include page="header.jsp" />
<head>
	<script>
		async function fetchStates() {
			var provinceOrStateDropdown = document.getElementById("CustProv")
			provinceOrStateDropdown.innerHTML = "<option value=''>Select One...</option>";
			var url = "http://192.168.0.233:8088/Winter2022JSPDay4JPAExample_war_exploded/api/provincesAndStates/getStates";
			//fetch the json string from the url into a Promise object names agents
			var states = await fetch(url);
			//extract the json data from the Promise object into a json object
			let statesJSON = await states.json();
			//loop through the json array to build the options
			for (i = 0; i < statesJSON.length; i++) {
				$("#CustProv").append("<option value='" + statesJSON[i].stateCode + "'>"
						+ statesJSON[i].stateName + "</option>");
			}
		}
		async function fetchProvinces() {
			var provinceOrStateDropdown = document.getElementById("CustProv")
			provinceOrStateDropdown.innerHTML = "<option value=''>Select One...</option>";
			var url = "http://192.168.0.233:8088/Winter2022JSPDay4JPAExample_war_exploded/api/provincesAndStates/getProvinces";
			//fetch the json string from the url into a Promise object names agents
			var provinces = await fetch(url);
			//extract the json data from the Promise object into a json object
			let provincesJSON = await provinces.json();
			//loop through the json array to build the options
			for (i = 0; i < provincesJSON.length; i++) {
				$("#CustProv").append("<option value='" + provincesJSON[i].provinceCode + "'>"
						+ provincesJSON[i].provinceName + "</option>");
			}
		}
		function changeRegion()
		{
			var country = document.getElementById("CustCountry");
			if (country.value == "Canada")
			{
				console.log(country.value);
				fetchProvinces();
			}
			else if (country.value == "United States")
			{
				console.log(country.value);
				fetchStates();
			}
			else
			{
				console.log(country.value);
			}
		}

	</script>
</head>
<body onload="fetchProvinces()">
<div align="center">

	<div id="banner">
	
	
	</div>


	<div id="menu">
		
		<div align="right">
		
			<a href="index.jsp" onmouseover="mouseOver()" onmouseout="mouseOut()"><img src="images/homebut.gif" name="b1" border="0"></a>
			
			<a href="packages.jsp" onmouseover="mouseOver2()" onmouseout="mouseOut2()"><img src="images/packagebut.gif" name="b2" border="0"></a>

			<a href="register.jsp" onmouseover="mouseOver3()" onmouseout="mouseOut3()"><img src="images/registerbut.gif" name="b3" border="0"></a>
			
			<a href="contact.jsp" onmouseover="mouseOver4()" onmouseout="mouseOut4()"><img src="images/contactbut.gif" name="b4" border="0"></a>
			
			<a href="links.jsp" onmouseover="mouseOver5()" onmouseout="mouseOut5()"><img src="images/linksbut.gif" name="b5" border="0"></a>

		</div>
		
	</div>

	<div id="body">
		
		<%
			createProvinceAndStates();

			if (request.getParameter("submit") != null)
			{
				String [] customer = new String[11];
				customer[0] = (String)request.getParameter("CustFirstName");
				customer[1] = (String)request.getParameter("CustLastName");
				customer[2]= (String)request.getParameter("CustAddress");
				customer[3]= (String)request.getParameter("CustCity");
				customer[4] = (String)request.getParameter("CustProv");
				customer[5] = (String)request.getParameter("CustCountry");
				customer[6] = (String)request.getParameter("CustPostal");
				customer[7] = (String)request.getParameter("CustHomePhone");
				customer[8] = (String)request.getParameter("CustBusPhone");
				customer[9] = (String)request.getParameter("CustEmail");
				customer[10] = (String)request.getParameter("AgentID");
		
				//pass data to validation function
				String message = validate(customer);
				if (message.equals(""))
				{
					//if not valid set error message and redisplay form
					out.print("<h4 style='color:crimson'>" + createCustomer(customer) + "</h4>");
					
					//after writing customer data empty the array so form will be empty
					
						customer[0] = "";
						customer[1] = "";
						customer[2] = "";
						customer[3] = "";
						customer[4] = "";
						customer[5] = "";
						customer[6] = "";
						customer[7] = "";
						customer[8] = "";
						customer[9] = "";
						customer[10] = "";
				
					
					displayForm(customer, out);
				} else
				{
				   out.print("<h4 style='color:crimson'>" + message + "</h4>");
				   displayForm(customer, out);
			    }
			}
			else
			{
				//display form
				String [] customer = {"","","","","","","","","","",""};
				displayForm(customer, out);
			}
			%>
		
	</div>
	

	<div id="footer">
	
		<span>[</span>
		
		<a href="index.jsp">Home</a>
		
		<span>||</span>
		
		<a href="packages.jsp">Packages</a>
		
		<span>||</span>
		
		<a href="register.jsp">Registration</a>
		
		<span>||</span>
		
		<a href="contact.jsp">Contact Us</a>
		
		<span>||</span>
		
		<a href="links.jsp">Links</a>
		
		<span>]</span><br />
		
		<span>Copyright &copy; 2008</span>
		
		<br />
	
	</div>

</div>

</body>
</html>