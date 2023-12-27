package JavaBean;

public class Login {
    String logname = "", backNews="未登录";

    public String getLogname() {
        return logname;
    }

    public void setLogname(String logname) {
        this.logname = logname;
    }

    public String getBackNews() {
        return backNews;
    }

    public void setBackNews(String s) {
        backNews = s;
    }
}
