<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DHRSurveys.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DHRSurvey</title>
	<base href="http://dhrwebsrv/surveytest/" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <link href="~/stylesheets/homepage.css" media="screen" rel="stylesheet" type="text/css"/>
</head>
<body class="bg">
	<form id="submission" runat="server">
		<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
			<asp:UpdatePanel ID="UpdatePanel_Main" runat="server">
				<ContentTemplate>			
				<header class="masthead text-white text-center">
					<div class="container d-flex align-items-center flex-column">
						<img class="masthead-avatar mb-3" src="https://i.imgur.com/zttpaZw.png"/>
						<h1 class="masthead-heading text-uppercase mb-0">Patient Survey</h1>
						<h6 class="info"> Thank you for your preference, please let us know how your stay went</h6>
					</div>
				</header>
    
    			<div class="card text-center">
	  				<div class="card-body">
	  					<div class="test d-flex align-items-center flex-column">
			  				<div class="form-group inputs">
								  <asp:TextBox class="form-control" id="first" name="first" placeholder="First Name" runat="server"></asp:TextBox>
				  			</div>
				  			<div class="form-group inputs">
				    			<asp:TextBox type="text" class="form-control" id="last" name="last" placeholder="Last Name" runat="server"></asp:TextBox>
				  			</div>
				  			<div class="form-group inputs">
				    			<asp:TextBox type="integer" class="form-control" id="pat_phone" name="pat_phone" placeholder="Phone Number ex.956-123-4567" runat="server"></asp:TextBox>
				  			</div>
		  				</div>
					</div>
	  	

					<div class="sup d-flex align-items-center flex-column" style="padding-bottom: 1.5rem;">
						<div class="sup" style="width:75%; text-align: center; padding-bottom: 2rem;">
							<asp:Table ID="Table1" class="table table-striped" runat="server">
								<asp:TableHeaderRow class="thead-dark">
									<asp:TableHeaderCell></asp:TableHeaderCell>
									<asp:TableHeaderCell>Bad</asp:TableHeaderCell>
									<asp:TableHeaderCell>Neutral</asp:TableHeaderCell>
									<asp:TableHeaderCell>Excellent</asp:TableHeaderCell>
								</asp:TableHeaderRow>
								<asp:TableRow>
									<asp:TableHeaderCell style="text-align: left;">Admitting Staff Courtesy</asp:TableHeaderCell>
									<asp:TableCell><asp:RadioButton ID="Q1B" name="rating1" value="1" runat="server" GroupName="Group1"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q1N" name="rating1" value="2" runat="server" GroupName="Group1" /></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q1E" name="rating1" value="3" runat="server" GroupName="Group1"/></asp:TableCell>
								</asp:TableRow>
								<asp:TableRow>
									<asp:TableHeaderCell style="text-align: left;">Room Cleanliness</asp:TableHeaderCell>
									<asp:TableCell><asp:RadioButton ID="Q2B" name="rating2" value="1" runat="server" GroupName="Group2"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q2N" name="rating2" value="2" runat="server" GroupName="Group2"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q2E" name="rating2" value="3" runat="server" GroupName="Group2"/></asp:TableCell>
								</asp:TableRow>
								<asp:TableRow>
									<asp:TableHeaderCell style="text-align: left;">Noise Level</asp:TableHeaderCell>
									<asp:TableCell><asp:RadioButton ID="Q3B" name="rating3" value="1" runat="server" GroupName="Group3"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q3N" name="rating3" value="2" runat="server" GroupName="Group3"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q3E" name="rating3" value="3" runat="server" GroupName="Group3"/></asp:TableCell>
								</asp:TableRow>
								<asp:TableRow>
									<asp:TableHeaderCell style="text-align: left;">Food Quality</asp:TableHeaderCell>
									<asp:TableCell><asp:RadioButton ID="Q4B" name="rating4" value="1" runat="server" GroupName="Group4"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q4N" name="rating4" value="2" runat="server" GroupName="Group4"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q4E" name="rating4" value="3" runat="server" GroupName="Group4"/></asp:TableCell>
								</asp:TableRow>
								<asp:TableRow>
									<asp:TableHeaderCell style="text-align: left;">Nurse Courtesy</asp:TableHeaderCell>
									<asp:TableCell><asp:RadioButton ID="Q5B" name="rating5" value="1" runat="server" GroupName="Group5"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q5N" name="rating5" value="2" runat="server" GroupName="Group5"/></asp:TableCell>
									<asp:TableCell><asp:RadioButton ID="Q5E" name="rating5" value="3" runat="server" GroupName="Group5"/></asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</div>
						<span role="alert" id="nameError" aria-hidden="true" style="padding-bottom: 1rem;"">Missing or Incorrect Field</span>
						 <asp:Label ID="radioError" runat="server" Text=""></asp:Label>
						<asp:Button ID="submit" class="btn btn-success btn-md" runat="server" Text="submit" OnClick="submit_Click" />
						<br />
					</div>
				</div>
			</ContentTemplate>
		</asp:UpdatePanel>
	</form>
	<script src="./js/validate.js"></script>
</body>
</html>
