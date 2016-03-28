<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Cloud Runner</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="http://cdn.bootcss.com/ace/1.2.3/ace.js"
	type="text/javascript" charset="utf-8"></script>
<style type="text/css" media="screen">
.editor {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
}
</style>
<%@	include file="include.jsp"%>
<script type="text/javascript">
	$(function() {
		var editor1 = ace.edit("editor1");
		editor1.setTheme("ace/theme/monokai");
		editor1.getSession().setMode("ace/mode/java");
		$('#addTab').click(function() {
			var nextTab = $('#tabs li').size();
			// create the tab
			$('<li><a href="#tab'+nextTab+'" data-toggle="tab">File'+ nextTab+ '<span class="glyphicon glyphicon-remove close-control"></span></a></li>').appendTo('#tabs');
			// create the tab content
			var tab_pane = "<br/><input type='hidden' value='"+nextTab+"'/><div id='settings_row' class='row' style='margin-bottom: 12px;'>";
			tab_pane += $('#settings_row').html();
			tab_pane += "</div><input id='solutionLanguage"+nextTab+"' name='solutionLanguage"+nextTab+"' type='hidden' value='java'/>";
			tab_pane += "<pre id='embedded_ace_code' style='height: 400px;' class='col-md-12' style='margin-bottom: 12px;'><div class='editor' id='editor"+nextTab+"'></div></pre></div>";

			$('<div class="tab-pane fade in active" id="tab'+nextTab+'">'+ tab_pane + '</div>').appendTo('.tab-content');
			var editorx = ace.edit('editor' + nextTab);
			editorx.setTheme("ace/theme/monokai");
			editorx.getSession().setMode("ace/mode/java");
			$('#tabs a:last').tab('show');
		});
		$(document).on('change', '.lang-control', function() {
			var tabId = $(this).parent().parent().prev().val();
			var editor = ace.edit("editor" + tabId);
			var selectedLang = $(this).val();
			if (selectedLang == 'java') {
				editor.getSession().setMode("ace/mode/java");
				$("#solutionLanguage").val("java");
				editor.setValue(javaPre);
			} else if (selectedLang == 'c') {
				editor.getSession().setMode("ace/mode/c_cpp");
				$("#solutionLanguage" + tabId).val("c");
				editor.setValue(cPre);
			} else if (selectedLang == 'cpp') {
				editor.getSession().setMode("ace/mode/c_cpp");
				$("#solutionLanguage" + tabId).val("cpp");
				editor.setValue(cPre);
			} else if (selectedLang == 'ruby') {
				editor.getSession().setMode("ace/mode/ruby");
				$("#solutionLanguage" + tabId).val("rb");
				editor.setValue(rbPre);
			} else if (selectedLang == 'python') {
				editor.getSession().setMode("ace/mode/python");
				$("#solutionLanguage" + tabId).val("py");
				editor.setValue(pyPre);
			} else if (selectedLang == 'haskell') {
				editor.getSession().setMode("ace/mode/haskell");
				$("#solutionLanguage" + tabId).val("hs");
				editor.setValue(hsPre);
			} else if (selectedLang == 'php') {
				editor.getSession().setMode("ace/mode/php");
				$("#solutionLanguage" + tabId).val("php");

			} else if (selectedLang == 'go') {
				editor.getSession().setMode("ace/mode/golang");
				$("#solutionLanguage" + tabId).val("go");

			} else if (selectedLang == 'javascript') {
				editor.getSession().setMode("ace/mode/js");
				$("#solutionLanguage" + tabId).val("javascript");

			} else if (selectedLang == 'swift') {
				editor.getSession().setMode("ace/mode/swift");
				$("#solutionLanguage" + tabId).val("swift");

			}
		});
		$(document).on('click', '.close-control', function() {
			$('#closeModal').modal();
			$(this).parent().parent().remove();
			var closing_tab_pane = $(this).parent().attr('href');
			var tabId = $(closing_tab_pane).children().next().val();
			var editor = ace.edit("editor" + tabId);
			editor.destroy();
			$(closing_tab_pane).remove();
			$('#tabs a:last').tab('show');
		});
		$(document).on('click', '.run-control', function() {
			var tabId = $(this).parent().parent().prev().val();
			var editor = ace.edit("editor" + tabId);
			$.ajax({
				type : 'POST',
				url : '${ctx}/problems/cloudRun',
				data : {
					codeSubmit : editor.getValue(),
					solutionLanguage : $('#solutionLanguage' + tabId).val()
				},
				success : function(data) {
					if (data.msg == "true") {

					} else {

					}
				}
			});
		});
		$(document).on('change', '.theme-control', function() {
			var tabId = $(this).parent().parent().prev().val();
			var editor = ace.edit("editor" + tabId);
			var selectedTheme = $(this).val();
			if (selectedTheme == 'monokai')
				editor.setTheme("ace/theme/monokai");
			else if (selectedTheme == 'xcode')
				editor.setTheme("ace/theme/xcode");
			else if (selectedTheme == 'eclipse')
				editor.setTheme("ace/theme/eclipse");
			else if (selectedTheme == 'solarized')
				editor.setTheme("ace/theme/solarized_dark");
		});
		$(document).on('click', '.reset-control', function() {
			var tabId = $(this).parent().parent().prev().val();
			var editor = ace.edit("editor" + tabId);
			editor.setValue("");
		});
	});
</script>
</head>
<body>
	<%@	include file="topnav.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-offset-1 col-md-10">
				<ul id="tabs" class="nav nav-tabs">
					<li><a id="addTab"> <span class="glyphicon glyphicon-plus"></a></li>
					<li class="active"><a href="#tab1" data-toggle="tab">
							File1 </a></li>
				</ul>
				<div id="tabContents" class="tab-content">
					<div class="tab-pane fade in active" id="tab1">
						<br /> <input id="tabId" type="hidden" value="1" />
						<div id="settings_row" class="row" style="margin-bottom: 12px;">
							<div class="col-lg-2">
								<select class="form-control lang-control" id="lang">
									<option value="c">C</option>
									<option value="cpp">C++</option>
									<option value="java" selected="selected">Java</option>
									<option value="python">Python</option>
									<option value="ruby">Ruby</option>
									<option value="haskell">Haskell</option>
									<option value="php">Php</option>
									<option value="go">Go</option>
									<option value="javascript">Javascript</option>
									<option value="swift">Swift</option>
								</select>
							</div>
							<div class="col-lg-2">
								<select id="theme" class="form-control theme-control">
									<option value="monokai" selected="selected">Monokai</option>
									<option value="xcode">Xcode</option>
									<option value="eclipse">Eclipse</option>
									<option value="solarized">Solarized</option>
								</select>
							</div>
							<div class="col-lg-6">
								<button class="btn btn-default reset-control" type="button">
									<span class="glyphicon glyphicon-refresh"></span>
								</button>
								<button id="run" class="btn btn-success btn-pad run-control"
									type="submit" data-original-title="Shortcut: Command + enter">run</button>
							</div>
						</div>
						<input id="solutionLanguage1" name="solutionLanguage1"
							type="hidden" value="java" />
						<pre id="embedded_ace_code" style="height: 400px;"
							class="col-md-12" style="margin-bottom: 12px;">
							<div id="editor1" class="editor"></div>
						</pre>
						<div id="resultDiv" class="alert alert-info alert-dismissable">

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<%@	include file="footer.jsp"%>
	<div class="modal fade" id="closeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h3>Sure to Close ?</h3>
					<p>You will lose your file process !</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>