package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component
@Aspect
public class AdminAspect {
	@Around("execution(* controller.Admin*.*(..))")
	public Object adminCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		Object[] args = joinPoint.getArgs();
		User loginUser = null;
		HttpSession session = null;
		for(Object o :args) {
			if(o instanceof HttpSession) {
				session = (HttpSession)o;
				loginUser = (User)session.getAttribute("loginUser");
			}
		}
		if(loginUser == null) {
			throw new LoginException("�α��� �� �̿��ϼ���.","../user/main.shop");
		}
		if(!loginUser.getUserId().equals("admin")) {
			throw new LoginException("�����ڸ� �̿� �����մϴ�.","../user/mypage.shop?id="+loginUser.getUserId());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
