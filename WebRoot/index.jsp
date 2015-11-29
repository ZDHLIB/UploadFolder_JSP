<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>测试文件上传</title>

		<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>

		<script language="javascript" type="text/javascript">

$(function() {
	//ShowFolderFileList("D:\\CodeNet\\web\\Images\\shopTemplets");
});

function ShowFolderFileList(FilePath) {
	var fso, f, fc, sf;
	fso = new ActiveXObject("Scripting.FileSystemObject");
	try {
		f = fso.GetFolder(FilePath);
	} catch (err) {
		alert("文件路径错误或者不存在!!");
		return false;
	}

	// 列出所有文件
	fc = new Enumerator(f.files);

	var fileName = "";

	for (; !fc.atEnd(); fc.moveNext()) {
		fileName = fc.item().Name;
		$(
				'<div filePath="' + FilePath + fileName
						+ '" uploadState="wait">' + FilePath + fileName
						+ '</div>').appendTo('#showArea');
	}

	// 循环 递归 读取 文件夹的文件
	sf = new Enumerator(f.SubFolders);
	var folderName = "";

	for (; !sf.atEnd(); sf.moveNext()) {
		folderName = sf.item().Name;
		ShowFolderFileList(FilePath + folderName + "/");
	}
}

function startUpload() {
	var s = $('#uploaddir').val().replace(/\\/gi, '/');
	if (s.substring(s.length - 1, s.length) != '/') {
		s += '/'
	}

	ShowFolderFileList(s)
	uploadFile();
}

// 上传
function uploadFile() {
	if ($('#showArea div[uploadState=wait]').length > 0) {
		var thisNode = $('#showArea div[uploadState=wait]').eq(0)
		var WshShell = new ActiveXObject("WScript.Shell");
		$('#fileupload').focus();
		WshShell.SendKeys($(thisNode).attr('filePath')); // 路径中不有是中文 

		uploadForm.submit();
		$('#fileupload').focus();
		$('#fileupload').get(0).createTextRange().select();
		WshShell.SendKeys('{del}');

		var dotStr = '.';
		$('<span></span>').appendTo(thisNode).css('color', 'green');
		var uploadState = setInterval(function() {
			if ($(thisNode).attr('uploadState') == 'ok') {
				clearInterval(uploadState);
				$(thisNode).find('span').css('color', 'red').text('(完成)');
				uploadFile();
			} else {
				if (dotStr.length > 15) {
					dotStr = '.';
				} else {
					dotStr += '.';
				}
				$(thisNode).find('span').text('(上传中' + dotStr + ')');
			}
		}, 1000);

	}
}

// 在iframe 的返回页面中调用此函数 即可实现循环上传，，否则为死循环
function uploadFinish() {
	$('#showArea div[uploadState=wait]').eq(0).attr('uploadState', 'ok');
}
</script>

		<style type="text/css">
body,td,th {
	font-family: "微软雅黑", Tahoma, Helvetica, Arial, \5b8b\4f53, sans-serif;
}
</style>

	</head>



	<body>

		<form action="/a.html" method="post" name="loginForm"
			style="margin: 0 0; padding: 0 0;">
			<input name="uploaddir" id="uploaddir" type="text" value="D:\a"
				style="width: 800px;" />
			<input type="button" value="开始" id="startIt" name="startIt"
				onclick="javascript:startUpload();" />
		</form>

		<form action="/index/upload" method="post" name="uploadForm"
			enctype="multipart/form-data" target="hidden_frame">
			<input type="file" name="fileupload" id="fileupload" />
			<iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe>
		</form>
		</iframe>
		<div id="showArea">
		</div>

	</body>

</html>
