﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FacultyLoadReport.aspx.cs" Inherits="University.Academics.FacultyLoadReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Academics Module" />
    <meta name="author" content="Sri Nuthalapati" />
    <title>FacultyLoad</title>
    <%-- ------ css ------ --%>
    <link href="../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../css/animate.min.css" rel="stylesheet" type="text/css" />
    <link href="../css/prettyPhoto.css" rel="stylesheet" type="text/css" />
    <link href="../css/main.css" rel="stylesheet" type="text/css" />
    <link href="../css/responsive.css" rel="stylesheet" type="text/css" />
     <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css"
        rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
    <script src="../js/html5shiv.js"></script>
    <script src="../js/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="../images/favicon.ico" />
</head>

    
<body>

    <form id="FacultyLoadReport" runat="server">
    
    <header id="header">
    <nav class="navbar navbar-inverse" role="banner">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../Default.aspx">University - Home</a>
                </div>
				
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="AcademicsHome.aspx">Academics - Home</a></li>
                        <li><a href="DepartmentCreation.aspx">Create Department</a></li>
                        <li><a href="ProgramCreation.aspx">Create Program</a></li>                        
                        <li><a href="CourseCreation.aspx">Create Course</a></li>                  
                        <li><a href="AssignFacultyToCourse1.aspx">Faculty Course Assignments</a></li> 
                        <li><a href="FacultyLoadReport.aspx">Faculty Load Report</a></li>                  
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
    </header>
        <div>
            <p style="width: 203px; margin-left: 600px">
            <b>Faculty Load Report</b></p><br/>
        </div>
            
        <asp:Label ID="DeptIDLbl" runat="server" Text="Department ID:"></asp:Label>
        <asp:DropDownList ID="DeptIDDDL" runat="server" DataSourceID="DeptIDs_DataSource" DataTextField="department_id" DataValueField="department_id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="DeptIDs_DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UniversityConnectionString %>" SelectCommand="SELECT DISTINCT [department_id] FROM [department]"></asp:SqlDataSource>
        <p>
            &nbsp;</p>
    
        <asp:Label ID="FacultyIDLbl" runat="server" Text="Faculty ID:"></asp:Label>
        <asp:DropDownList ID="FacultyIDDDL" runat="server" DataSourceID="FacultyIDs_DeptID_DataSource" DataTextField="fuser_id" DataValueField="fuser_id" AutoPostBack="True">
        </asp:DropDownList>
            
        <asp:SqlDataSource ID="FacultyIDs_DeptID_DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UniversityConnectionString %>" SelectCommand="SELECT DISTINCT [fuser_id] FROM [faculty] WHERE ([department_id] = @department_id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DeptIDDDL" DefaultValue="17" Name="department_id" PropertyName="SelectedValue" Type="Int16" />
            </SelectParameters>
        </asp:SqlDataSource>
            
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:GridView ID="FacultyLoadGridView" runat="server" DataSourceID="FacultyReportDataSource" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="section_id" AllowPaging="True" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" PageSize="5">
            <Columns>
                <asp:BoundField DataField="Faculty_Name" HeaderText="Faculty_Name" SortExpression="Faculty_Name" />
                <asp:BoundField DataField="Faculty_ID" HeaderText="Faculty_ID" SortExpression="Faculty_ID" />
                <asp:BoundField DataField="course_name" HeaderText="course_name" SortExpression="course_name" />
                <asp:BoundField DataField="section_id" HeaderText="section_id" ReadOnly="True" SortExpression="section_id" />
                <asp:BoundField DataField="semester" HeaderText="semester" SortExpression="semester" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="FacultyReportDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UniversityConnectionString %>" SelectCommand="select info.first_name as 'Faculty_Name', sec.fuser_id as 'Faculty_ID', crs.course_name, sec.section_id, sec.semester from section as sec, user_info as info, course as crs where sec.fuser_id = @fuser_id and sec.fuser_id = info.user_id and sec.course_id = crs.course_name">
            <SelectParameters>
                <asp:ControlParameter ControlID="FacultyIDDDL" DefaultValue="57" Name="fuser_id" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
            
    </form>
</body>
</html>
