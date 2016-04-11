<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>PlusOnlineJudge!</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="//cdn.tinymce.com/4/tinymce.min.js"
	type="text/javascript" charset="utf-8"></script>
<%@	include file="include.jsp"%>
<script type="text/javascript">
	tinymce.init({
		selector : '#problemContent',
		menubar : false,
		statusbar : false,
		init_instance_callback : function(editor) {
		    editor.setContent('${problem.problemContent}');
		}
	});
	tinymce.init({
		selector : '.problemIO',
		menubar : false,
		statusbar : false,
		toolbar : false
	});
	function initIO(testNum,testId,testInput,testOutput){
		$("#problemI"+testNum).val(testInput);
		$("#problemO"+testNum).val(testOutput);
		$("#ioId"+testNum).val(testId);
	}
	$(function() {
		var problemLanguage = '${problem.problemLanguage}';
		var languages = problemLanguage.split('&');
		for (var i=0;i<languages.length;i++)
		{
			$("input[value='"+languages[i]+"']").parent().attr('class', 'label label-success');
		}
		$('.label').click(function() {
			if ($(this).attr('class') == 'label label-success')
				$(this).attr('class', 'label label-default');
			else if ($(this).attr('class') == 'label label-default')
				$(this).attr('class', 'label label-success');
		});
		$('#saveProblem').click(function() {
			var problemLanguage = '';
			var problemDigest = $('#problemDigest').val();
			var problemContent = tinymce.get('problemContent').getContent();
			$('.label-success').each(function(i){
				problemLanguage += '&'+$(this).children().val();
			});
			if(problemLanguage == ''){
				$('#warningContent').html('<strong>Please choose Problem Language !</strong>');
				$('#warningModal').modal("show");
				return;
			}
			if(problemDigest == ''){
				$('#warningContent').html('<strong>Please give the Problem Digest out !</strong>');
				$('#warningModal').modal("show");
				return;
			}
			if(problemContent == ''){
				$('#warningContent').html('<strong>Please add the Problem Content !</strong>');
				$('#warningModal').modal("show");
				return;
			}
			$.ajax({
				type : 'POST',
				url : '${ctx}/problems/tempSaveProblem',
				data : {
					problemId : $('#problemId').val(),
					problemDigest : problemDigest,
					problemContent : problemContent,
					problemLanguage : problemLanguage
				},
				success : function(result) {

				}
			});
		});
		$('#postProblem').click(function() {

		});
		$('#ioSaveButton').click(function(){
			
		});
		
		$('#showTest').click(function(){
			alert(tinymce.get('problemInput').getContent());
			alert(tinymce.get('problemOutput').getContent());
		});
		$(document).on('click', '.io-control', function(e) {
			var testNum = $(this).children().val();
			tinymce.get('problemInput').setContent($('#problemI'+testNum).val());
			tinymce.get('problemOutput').setContent($('#problemO'+testNum).val());
			$('#problemIOModal').modal("show");
		});
	});
</script>
</head>
<body>
	<%@	include file="topnav.jsp"%>
	<div class="container">
		<div class='row col-md-12'>
			<div class="post-title" style="overflow: hidden;">
				<h3 style="display: inline-block; margin-top: 0px;">
					You can edit the problem here with the problem contents , inputs and
					outputs here and post them to <span class="orange">PlusOJ!</span>
				</h3>
				<h5>Tips : You can use the format tools to make your problem
					well typographical !</h5>
			</div>
		</div>
		<hr>
		<br>
		<div class="row">
			<div class="col-md-8">
				<div class="input-group row">
					<span class="input-group-addon">Digest</span> <input
						id="problemDigest" type="text" class="form-control"
						placeholder="Describe the problem" value="${problem.problemDigest}">
				</div>
				<br>
				<div class="row">
					<textarea id="problemContent" style="height: 350px;">
					</textarea>
				</div>
			</div>
			<div class="col-md-4">
				<button id="saveProblem" class="btn btn-default btn-pad">
					<span class="glyphicon glyphicon-save"></span>&nbsp;Save
				</button>
				<button id="postProblem" class="btn btn-success btn-pad">
					<span class="glyphicon glyphicon-send"></span>&nbsp;Post
				</button>
			</div>
			<div class="col-md-4">
				<hr>
			</div>
			<div class="col-md-4">
				<span class="label label-default"><input type="hidden"
					value="c" />C</span> 
				<span class="label label-default"><input
					type="hidden" value="cpp" />C++</span> 
				<span class="label label-default"><input
					type="hidden" value="java" />Java</span> 
				<span class="label label-default"><input
					type="hidden" value="ruby" />Ruby</span> 
				<span class="label label-default"><input
					type="hidden" value="python" />Python</span> 
				<span class="label label-default"><input type="hidden"
					value="haskell" />Haskell</span> 
				<span class="label label-default"><input
					type="hidden" value="go" />Go</span> 
				<span class="label label-default"><input
					type="hidden" value="swift" />Swift</span>
			</div>
			<div class="col-md-4">
				<hr>
			</div>
			<div class="col-md-4">
				<div class="panel panel-primary io-control">
					<input id="ioId1" type="hidden"/>
					<div id="ioPanel1" class="panel-heading">
						<h3 class="panel-title">
							<span class="glyphicon glyphicon-th-list"></span> &nbsp;Input and
							Output #1
						</h3>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div id="ioPanel2" class="panel panel-primary io-control">
					<input id="ioId2" type="hidden"/>
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="glyphicon glyphicon-th-list"></span> &nbsp;Input and
							Output #2
						</h3>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div id="ioPanel3" class="panel panel-primary io-control">
					<input id="ioId3" type="hidden"/>
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="glyphicon glyphicon-th-list"></span> &nbsp;Input and
							Output #3
						</h3>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div id="ioPanel4" class="panel panel-primary io-control">
					<input id="ioId4" type="hidden"/>
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="glyphicon glyphicon-th-list"></span> &nbsp;Input and
							Output #4
						</h3>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div id="ioPanel5" class="panel panel-primary io-control">
					<input id="ioId5" type="hidden"/>
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="glyphicon glyphicon-th-list"></span> &nbsp;Input and
							Output #5
						</h3>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<hr>
			</div>

		</div>
	</div>
	<%@	include file="footer.jsp"%>
	<div class="modal fade" id="problemIOModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 class="modal-title" id="myModalLabel">
						<strong>You should give several groups of inputs and
							outputs here</strong>
					</h3>
				</div>
				<div class="modal-body">
					<p>Problem Input Here!</p>
					<textarea class="problemIO" id="problemInput"
						style="height: 150px;">Write down the problem input here !</textarea>
					<hr>
					<p>Problem Output fit input above Here!</p>
					<textarea class="problemIO" id="problemOutput"
						style="height: 150px;">Write down the problem output here !</textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
					<button id="showTest" type="button" class="btn btn-default" data-dismiss="modal">show</button>
					<button id="ioSaveButton" type="button" class="btn btn-success">save</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="warningModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 class="modal-title" id="myModalLabel">
						<strong>Waring</strong>
					</h3>
				</div>
				<div class="modal-body">
					<p id="warningContent"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>
	<div class="hiddenPart" style="display: none">
		<input id="problemId" value="${problem.problemId }"/>
		<textarea id="problemI1"></textarea>
		<textarea id="problemO1"></textarea>
		<textarea id="problemI2"></textarea>
		<textarea id="problemO2"></textarea>
		<textarea id="problemI3"></textarea>
		<textarea id="problemO3"></textarea>
		<textarea id="problemI4"></textarea>
		<textarea id="problemO4"></textarea>
		<textarea id="problemI5"></textarea>
		<textarea id="problemO5"></textarea>
		<c:set var="testNum" value="0"></c:set>
		<c:forEach items="${problemTests }" var="test">
			<c:set var="testId" value="${test.problemTestId }"></c:set>
			<c:set var="testInput" value="${test.problemTestInput }"></c:set>
			<c:set var="testOutput" value="${test.problemTestOutput }"></c:set>
			<script type="text/javascript">
				initIO("${testNum+1}","${testId}","${testInput}","${testOutput}");
			</script>
			<c:set var="testNum" value="${testNum+1}"></c:set>
		</c:forEach>
		
	</div>
</body>
</html>