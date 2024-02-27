<!--#include file="./templates/dbconnection.asp"-->
<!--#include file="./templates/header.asp"-->

<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./assets/css/profile.css">

<%
set rs = server.createobject("adodb.recordset")
rs.open "SELECT * FROM profiles WHERE userid='" & Session("uid") & "'", cn
%>

<div class="container">
   <div class="row">
       <div class="col-md-12">
<div class="container">
   <div class="row">
      <div class="col-md-12">
         <div id="content" class="content content-full-width">
            <div class="profile">
               <div class="profile-header">
                  <div class="profile-header-cover"></div>
                  <div class="profile-header-content">
                     <div class="profile-header-img">
                        <img src="<%=  rs.fields("photo")%>" alt="">
                     </div>
                     <div class="profile-header-info">
                        <h4 class="m-t-10 m-b-5"><%response.write(rs.fields("complete_name"))%></h4>

                        <%
                        response.write "<a href='editprofile.asp?id=" & rs.fields("userid") & "'title='Edit account' class='btn btn-sm btn-info mb-2'> Edit Profile</a> &nbsp;"
                        response.write "<a href='changeavatar.asp?id=" & rs.fields("userid") & "'title='Change avatar' class='btn btn-sm btn-info mb-2'> Change Avatar</a>"
                        %>
                     </div>
                  </div>

                  <ul class="profile-header-tab nav nav-tabs">
                     <li class="nav-item"><a href="mycontents.asp" class="nav-link_">MY CONTENTS</a></li>
                  </ul>

               </div>
            </div>

            <div class="profile-content">
               <div class="tab-content p-0">

                  <div class="tab-pane fade in active show" id="profile-about">
                     <div class="table-responsive">
                        <table class="table table-profile">
                           <thead>
                              <tr>
                                 <th></th>
                                 <th>
                                    <h4><%response.write(rs.fields("complete_name"))%></h4>
                                 </th>
                              </tr>
                           </thead>
                           <tbody>
                              <tr>
                                 <td class="field">Gender</td>
                                 <td><p><%response.write(rs.fields("gender"))%></p></td>
                              </tr>
                              <tr>
                                 <td class="field">Email Address</td>
                                 <td><p><%response.write(rs.fields("email_address"))%></p></td>
                              </tr>
                              
                              <tr class="divider">
                                 <td colspan="2"></td>
                              </tr>
                              <tr class="highlight">
                                 <td class="field">About Me</td>
                                 <td><p><%response.write(rs.fields("aboutme"))%></p></td>
                              </tr>
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
    	</div>
	</div>
</div>

<!--#include file="./templates/footer.asp"-->
