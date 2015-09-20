<%@ Page Language="C#" %>
<script runat="server">
	void Page_Load(object sender, EventArgs e){
		if(Request.Form["field1"] != null ){
			Response.Write("field1 : " + Request.Form["field1"] + "</br>");
		}
		if(Request.Form["field2"] != null ){
			Response.Write("field2 : " +Request.Form["field2"] + "</br>");
		}
	}
</script>