<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ ��� ȭ��</title>
<script>
   var oTbl;
   //Row �߰�
   var idx1 = 0;
   var idx2 = 0;
   function insRow(a) {
      oTbl = document.getElementById("addTable" + a);
      var oRow = oTbl.insertRow();
      oRow.onmouseover = function() {
         oTbl.clickedRowIndex = this.rowIndex
      }; //clickedRowIndex - Ŭ���� Row�� ��ġ�� Ȯ��;

      //���Ե� Form Tag
      if (a == 1) {
         ++idx1;
         var frmTag = "<tr><td><input type='text' name='size["+idx1+"].size'></td><td><input type='text' name='size["+idx1+"].quantity'></td>";
//         var frmTag = "<tr><td><input type='text' name='size'></td><td><input type='text' name='quantity'></td>";
      } else if (a == 2) {
         ++idx2;
         var frmTag = "<td><input type='file' name='picturelist["+idx2+"].picture'></td><td><input type='text' name='picturelist["+idx2+"].type'></td><td align='left'></td>";
//         var frmTag = "<td><input type='file' name='pictureurl'></td><td><input type='text' name='type'></td><td align='left'></td>";
      }
      frmTag += "<td><input type=button value='����' onClick='removeRow("+a+")' style='cursor:hand'></td></tr";
      oRow.innerHTML = frmTag;
   }
   //Row ����
   function removeRow(a) {
      if(a==1){--idx1;}
      else if(a==2){--idx2;}
      oTbl.deleteRow(oTbl.clickedRowIndex);
   }

   function frmCheck() {
      var frm = document.form;

      for (var i = 0; i <= frm.elements.length - 1; i++) {
         if (frm.elements[i].name == "addText") {
            if (!frm.elements[i].value) {
               alert("�ؽ�Ʈ�ڽ��� ���� �Է��ϼ���!");
               frm.elements[i].focus();
               return;
            }
         }
      }
   }
   function showSub(obj) {
	     f = document.forms.select_machine;
	     var x = document.getElementById('sub1')
	     if(obj == 1) {   
/* 	        document.getElementById('sub1').style.display = "";
	        document.getElementById('sub2').style.display = "none";
	        document.getElementById('sub3').style.display = "none";
	        document.getElementById('sub4').style.display = "none";
 */ 
            
         } else if(obj==2){
/* 	        document.getElementById('sub1').style.display = "none";
	        document.getElementById('sub2').style.display = "";
	        document.getElementById('sub3').style.display = "none";
	        document.getElementById('sub4').style.display = "none";
 */
             x = document.getElementById('sub2');

           }else if(obj==3){
/* 	        document.getElementById('sub1').style.display = "none";
	         document.getElementById('sub2').style.display = "none";
	         document.getElementById('sub3').style.display = "";
	         document.getElementById('sub4').style.display = "none";
 */          x = document.getElementById('sub3');
	       }else{
	    	   /* 	        document.getElementById('sub1').style.display = "none";
	           document.getElementById('sub2').style.display = "none";
	           document.getElementById('sub3').style.display = "none";
	           document.getElementById('sub4').style.display = "";
 */          x = document.getElementById('sub4');
        }
	   var sub = document.getElementById('sub');
       for(var i = sub.options.length-1;i >= 0;i--) {
    	   sub.options.remove(i);
       }
       for(var i = 0;i< x.options.length;i++) {
    	   var opt = document.createElement("option");
    	   opt.text= x.options[i].text
    	   opt.value = x.options[i].value
 	       document.getElementById('sub').add(opt)   
       }
	 }
</script>
</head>
<body>
   <div align="center">
      <form:form modelAttribute="item" action="itemadd.shop"
         enctype="multipart/form-data">
         <h2>��ǰ ��� ȭ��</h2>
         <div style="float: left; width: 50%;">
            <table>
               <tr>
                  <td>��ǰ��</td>
                  <td><form:input path="name" maxlenght="20" /></td>
                  <td><font color="red"><form:errors path="name" /></font></td>
               </tr>
               <tr>
                  <td>����</td>
                  <td><form:input path="cost" maxlenght="7" /></td>
                  <td><font color="red"><form:errors path="cost" /></font></td>
               </tr>
               <tr>
                  <td>�귣��</td>
                  <td><form:input path="brand" maxlenght="10" /></td>
                  <td><font color="red"><form:errors path="brand" /></font></td>
               </tr>
               <tr>
                  <td>����</td>
                  <td><form:input path="price" maxlenght="7" /></td>
                  <td><font color="red"><form:errors path="price" /></font></td>
               </tr>
               <tr>
                  <td>������</td>
                  <td><form:input path="discount" maxlenght="7" /></td>
                  <td><font color="red"><form:errors path="discount" /></font></td>
               </tr>
               <tr>
                  <td>����</td>
                  <td><form:input path="color" maxlenght="10" /></td>
                  <td><font color="red"><form:errors path="color" /></font></td>
               </tr>
               <tr>
                  <td>����</td>
                  <td><form:input path="total" maxlenght="6" /></td>
                  <td><font color="red"><form:errors path="total" /></font></td>
               </tr>
               <tr>
                  <td>��ǰ����</td>
                  <td><form:textarea path="content" cols="21" rows="5" /></td>
                  <td><font color="red"><form:errors path="content" /></font></td>
               </tr>
              <tr><td><select name="cate" onChange="showSub(this.options[this.selectedIndex].value);"> 
<option value="1">�ȭ</option> 
<option value="2">����</option> 
<option value="3">����</option> 
<option value="4">����</option> 
</select>

<select name="subcate" id="sub" ></select>

<select  id="sub1" style="display : none;">
<option value="1">����Ŀ��</option>
<option value="2">����ȭ</option>
<option value="3">������</option>
</select>
<select  id="sub2" style="display: none ;">
<option value="4">��������</option>
<option value="5">����</option>
<option value="6">��</option>
</select>
<select   id="sub3" style="display: none ;">
<option value="7">�ø��ö�</option>
<option value="8">�����̵�</option>
<option value="9">��Ʈ��</option>
</select>
<select  id="sub4" style="display: none;">
<option value="10">��Ŀ</option>
<option value="11">��Ŭ</option>
<option value="12">��</option>
</select></td></tr>
            </table>
         </div>
         <div style="float: left; width: 50%;">
            <table>
               <tr>
                  <td colspan="3">����� ����</td>
               </tr>
               <tr>
               <tr>
                  <td height="25">
                     <table id="addTable1" width="400" cellspacing="0" cellpadding="0"
                        bgcolor="#FFFFFF" border="0">
                        <tr>
                           <td>������</td>
                           <td>����</td>
                           <td></td>
                        </tr>
                        <tr><td><input type="text" name="size[0].size"></td>
                        <td><input type="text" name="size[0].quantity"></td>
                        <td align="left"></td>
                        </tr>
                     </table>
                  </td>
               </tr>
               <tr>
                  <td align="right"><input name="addButton" type="button"
                     style="cursor: hand" onClick="insRow(1)" value="�߰�"></td>
               </tr>
            </table>
         </div>

         <div style="float: left; width: 100%; padding: 10px;">
            <hr>
            <table>
               <tr>
                  <td colspan="3">����</td>
               </tr>
               <tr>
                  <td height="25">
                     <table id="addTable2" width="400" cellspacing="0" cellpadding="0"
                        bgcolor="#FFFFFF" border="0">
                        <tr>
                           <td>������</td>
                           <td>Ÿ��(��� ���� 1, �ϴܻ���: 2)</td>
                           <td></td>
                        </tr>
                        <tr><td><input type="file" name="picturelist[0].picture"></td>
                        <td><input type="text" name="picturelist[0].type"></td>
                        <td align="left"></td>
                        </tr>
                     </table>
                  </td>
               </tr>
               <tr>
                  <td align="right"><input name="addButton" type="button"
                     style="cursor: hand" onClick="insRow(2)" value="�߰�"></td>
               </tr>
            </table>

            <table>
               <tr>
                  <td colspan="3"><input type="submit" value="���">&nbsp;
                     <input type="button" value="��ǰ���"
                     onclick="location.href='list.shop'"></td>
               </tr>
            </table>
         </div>
      </form:form>
   </div>
</body>
</html>