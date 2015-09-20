<%@ Page Language="C#" AutoEventWireup="true" Inherits="RemotePost" %>
<%@ import Namespace="System.Text" %>

<script runat="server">
	
	void PostMe(Object sender,EventArgs e){
		RemotePost myremotepost =  new RemotePost();
		myremotepost.Url = "http://www.jigar.net/demo/HttpRequestDemoServer.aspx";
		myremotepost.Add("field1","Tom");
		myremotepost.Add("field2","Sawyer");
		myremotepost.Post();
	}

	void PostMe2(Object sender,EventArgs e){
		RemotePost myremotepost =  new RemotePost();
		myremotepost.Url = "http://www.jigar.net/demo/HttpRequestDemoServer.aspx";
		myremotepost.Add("field1","Huckleberry");
		myremotepost.Add("field2","Finn");
		myremotepost.Post();
	}

	public class RemotePost{
			
	}
</script>
<html>
<head>
</head>
<body>
    <form runat="Server">
		<div style="">
		<p>This Button will post field1="Tom" and field2="Sawyer"; </p>
		<asp:button runat="Server" onclick="PostMe" Text="Post"/>
		</div>

		<div>
		<p>This Button will post field1="Huckleberry" and field2="Finn"; </p>
		<asp:button runat="Server" onclick="PostMe2" Text="Post"/>
		</div>
		
	</form>
</body>
</html>