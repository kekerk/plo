package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component //��üȭ
@Aspect //���� ��ü�� AOP ��ü��
public class LoginAspect {
	@Around("execution(* controller.User*.*(..)) && args(id, session,..)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, String id, HttpSession session) throws Throwable {
		User loginUser = (User)session.getAttribute("loginUser");
		//1.�α��� �ȵ� ���
		if(loginUser == null) {
			throw new LoginException("�α��� �� �̿� �����մϴ�.","../user/main.shop");
		}
		//2.admin�� �ƴϰ�, id�� �α��� ������ �ٸ� ���.
		if(!id.equals(loginUser.getUserId()) && !loginUser.getUserId().equals("admin")) {
			throw new LoginException("���θ� �̿� �����մϴ�.","../user/mypage.shop?id="+loginUser.getUserId());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
	@Around("execution(* controller.User*.*(..)) && args(session,user,..)")
	public Object userUpdateCheck(ProceedingJoinPoint joinPoint, HttpSession session, User user) throws Throwable {
		User loginUser = (User)session.getAttribute("loginUser");
		//1.�α��� �ȵ� ���
		if(loginUser == null) {
			throw new LoginException("�α��� �� �̿� �����մϴ�.","../user/main.shop");
		}
		//2.admin�� �ƴϰ�, id�� �α��� ������ �ٸ� ���.
		if(!user.getUserId().equals(loginUser.getUserId()) && !loginUser.getUserId().equals("admin")) {
			throw new LoginException("���θ� �̿� �����մϴ�.","../user/mypage.shop?id="+loginUser.getUserId());
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
