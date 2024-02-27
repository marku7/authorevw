<%
    set cn = server.createobject("ADODB.connection")
    cn.connectionstring="Driver={MySQL ODBC 8.0 UNICODE Driver}; Server=localhost; Database=authorevw; User=root; Password=root; Port=3306;"
    cn.open
  %>