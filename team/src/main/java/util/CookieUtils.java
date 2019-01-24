package util;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtils {

 
 private static final String encoding = "UTF-8";
 private static final String path = "/";
 
 
 /**
  * @description Ư�� key�� ��Ű���� List�� ��ȯ�Ѵ�.
  * @params key: ��Ű �̸�
  */
 public List<String> getValueList(String key, HttpServletRequest request) throws UnsupportedEncodingException{
  Cookie[] cookies = request.getCookies();
  String[] cookieValues = null;
  String value = "";
  List<String> list = null;
  
  // Ư�� key�� ��Ű���� ","�� �����Ͽ� String �迭�� ����ش�.
  // ex) ��Ű�� key/value ---> key = "clickItems", value = "211, 223, 303"(��ǰ ��ȣ)
  if(cookies != null){
   for(int i=0;i<cookies.length;i++){
    if(cookies[i].getName().equals(key)){
     value = cookies[i].getValue();
     cookieValues = (URLDecoder.decode(value, encoding)).split(",");
     break;
    }
   }
  }
  
  // String �迭�� ���� ������ List�� �ٽ� ��´�.
  if(cookieValues != null){
   list = new ArrayList<String>(Arrays.asList(cookieValues));
   
   if (list.size() > 3) { // ���� 3���� �ʰ��ϸ�, �ֱ� �� 3���� ��´�.
    int start = list.size() - 3;
    List<String> copyList = new ArrayList<String>();
    for (int i = start ; i < list.size() ; i++) {
     copyList.add(list.get(i));
    }
    list = copyList;
   }
  }
  return list;
 }
 
 /**
  * @description ��Ű�� ���� Ȥ�� ������Ʈ�Ѵ�.
  * @params key: ��Ű �̸�, value: ��Ű �̸��� ¦�� �̷�� ��, day: ��Ű�� ����
  */
 public void setCookie(String key, String value, int day, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
  List<String> list = getValueList(key, request);
  String sumValue = "";
  int equalsValueCnt = 0;
  
  if(list != null){
   for(int i=0; i<list.size(); i++){
    sumValue += list.get(i) + ",";
    if(list.get(i).equals(value)){
     equalsValueCnt++;
    }
   }
   if(equalsValueCnt != 0){ // ���� ���� �������� �� ���� ó��
    if(sumValue.substring(sumValue.length()-1).equals(",")){
     sumValue = sumValue.substring(0, sumValue.length()-1);
    }
   }else{
    sumValue += value;
   }
  }else{
   sumValue = value;
  }
  
  if(!sumValue.equals("")){
   Cookie cookie = new Cookie(key, URLEncoder.encode(sumValue, encoding));
   cookie.setMaxAge(60*60*24*day);
   cookie.setPath(path);
   response.addCookie(cookie);
  }
 }
 
/**
  * @description ��Ű���� �� Ư�� ���� �����Ѵ�.
  * @params key: ��Ű �̸�, value: ��Ű �̸��� ¦�� �̷�� ��
  */
 public void deleteCookie(String key, String value, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
  List<String> list = getValueList(key, request);
  list.remove(value);
  
  String sumValue = "";
  if(list.size() != 0){
   for(int i=0; i<list.size();i++){
    sumValue += list.get(i)+",";
   }
   if(sumValue.substring(sumValue.length()-1).equals(",")){
    sumValue = (sumValue.substring(0, sumValue.length()-1)).replaceAll(" ","");
   }
  }
  Cookie cookie = null;
  int time = 60*60*24*20;
  
  if(sumValue.equals("")){
   time = 0;
  }
  
  cookie = new Cookie(key, URLEncoder.encode(sumValue, encoding));
  cookie.setMaxAge(time);
  cookie.setPath(path);
  response.addCookie(cookie);
 }
 

 /**
  * @description �Ϲ����� ��Ű ����
  * @params key: ��Ű �̸�, value: ��Ű �̸��� ¦�� �̷�� ��,  day: ��Ű�� ����
  */
 public Cookie createNewCookie(String key, String value, int day, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
  Cookie cookie = new Cookie(key, URLEncoder.encode(value, encoding));
  cookie.setPath(path);
  cookie.setMaxAge(60*60*24*day);
  response.addCookie(cookie);
  return cookie;
 }

 /**
  * @description ��Ű���� ������ ��ȯ�Ѵ�.
  * @params 
  */
 public HashMap getValueMap(HttpServletRequest request){
  HashMap cookieMap = new HashMap();
  
  Cookie[] cookies = request.getCookies();
  if (cookies != null) {
   for (int i = 0; i < cookies.length; i++) {
    cookieMap.put(cookies[i].getName(), cookies[i]);
   }
  }
  
  return cookieMap;
 }
 
 /**
  * @description ","�� ���е� ���� �ƴ� ���� ������ ����� ��Ű�� ���� ��ȯ�Ѵ�.
  * @params key: ��Ű �̸�
  */
 public String getValue(String key, HttpServletRequest request) throws UnsupportedEncodingException {
  Cookie cookie = (Cookie) getValueMap(request).get(key);
  if (cookie == null) return null;
  return URLDecoder.decode(cookie.getValue(), encoding);
 }

 /**
  * @description ��Ű�� �ִ��� Ȯ��.
  * @params key: ��Ű �̸�
  */
 public boolean isExist(String key, HttpServletRequest request) {
  return getValueMap(request).get(key) != null;
 }
}