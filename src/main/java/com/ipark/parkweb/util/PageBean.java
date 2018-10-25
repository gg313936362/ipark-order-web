package com.ipark.parkweb.util;

/**
 * Created by cheng.wang on 2015/7/7.
 * 分页计算Bean（for MySql,Mybatis）
 */
public class PageBean {
    private int totalRecordNum;	// 总记录数
    private int totalPageNum; //一共多少页
    private int curPageNum = 1;  //当前页码数 (默认为1)
    private int pageSize;	  //每页显示记录数
    private int startIndex;   //记录开始位置

    /**
     * @param curPageNum -当前页码数 (默认为1)
     * @param totalRecordNum -总记录数
     * @param pageSize -每页显示记录数
     */
    public PageBean(int curPageNum, int totalRecordNum, int pageSize){
        if(pageSize == 0 || pageSize >100){
            pageSize = 100;
        }
        this.setTotalRecordNum(totalRecordNum);
        this.setPageSize(pageSize);
        this.setTotalPageNum();
        this.setCurPageNum(curPageNum);
        this.setStartIndex();
    }
    /**
     * @param totalRecordNum -总记录数
     * @param pageSize -每页显示记录数
     */
    public PageBean(int totalRecordNum, int pageSize){
        this.setTotalRecordNum(totalRecordNum);
        this.setPageSize(pageSize);
        this.setTotalPageNum();
        this.setCurPageNum(curPageNum);
        this.setStartIndex();
    }

    public int getTotalRecordNum() {
        return totalRecordNum;
    }

    public void setTotalRecordNum(int totalRecordNum) {
        this.totalRecordNum = totalRecordNum;
    }

    public int getTotalPageNum() {
        return totalPageNum;
    }
    /**	根据总记录数与每页显示数，计算一共多少页	*/
    public void setTotalPageNum() {
        if(totalRecordNum < pageSize){
            this.totalPageNum = 1;
        }else if(totalRecordNum % pageSize == 0){
            this.totalPageNum = totalRecordNum /pageSize ;
        }else{
            this.totalPageNum = totalRecordNum /pageSize + 1;
        }
    }

    public int getCurPageNum() {
        return curPageNum;
    }
    /** 如果当前页数小于1，则设置当前页数为1 */
    public void setCurPageNum(int curPageNum) {
        if(curPageNum < 1){
            this.curPageNum = 1;
        }/*else if(curPageNum > totalPageNum){//不对当前页数和总页数进行判断
			this.curPageNum = totalPageNum;
		}*/else{
            this.curPageNum = curPageNum;
        }
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getStartIndex() {
        return startIndex;
    }

    public void setStartIndex() {
        //this.firstResult = firstResult;
        this.startIndex = (curPageNum-1)*pageSize;
    }
}
