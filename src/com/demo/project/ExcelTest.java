package com.demo.project;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileOutputStream;
import java.io.OutputStream;

/**
 * Created by Administrator on 2016/2/20 0020.
 */
public class ExcelTest {

    public static void  main(String[]args){

        System.out.println("ddd");
        test();
    }


    public static void test(){
        //创建HSSFWorkbook对象(excel的文档对象)
    	XSSFWorkbook wb = new XSSFWorkbook();
        //建立新的sheet对象（excel的表单）
        XSSFSheet sheet=wb.createSheet("成绩表");

        
        // 设置表格默认列宽度为15个字节  
        sheet.setDefaultColumnWidth((short) 15);  
        // 生成一个样式  
        XSSFCellStyle style = wb.createCellStyle();  
        // 设置这些样式  
//        style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);  
//        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
//        style.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);  
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        // 生成一个字体  
        XSSFFont font = wb.createFont();  
//        font.setColor(HSSFColor.VIOLET.index);  
        font.setFontHeightInPoints((short) 12);  
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        // 把字体应用到当前的样式  
        style.setFont(font);  
        
        
        
        //在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
        XSSFRow row1=sheet.createRow(0);
        //创建单元格（excel的单元格，参数为列索引，可以是0～255之间的任何一个
        XSSFCell cell=row1.createCell(1);
        //设置单元格内容
        cell.setCellValue("学员考试成绩一览表");
        cell.setCellStyle(style);
        
        
        
        //合并单元格CellRangeAddress构造参数依次表示起始行，截至行，起始列， 截至列
        sheet.addMergedRegion(new CellRangeAddress(1,1,1,4));
        
        
        
        // 生成一个样式  
        XSSFCellStyle style2 = wb.createCellStyle();  
        // 设置这些样式  
//        style.setFillForegroundColor(HSSFColor.SKY_BLUE.index);  
//        style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
        style2.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);  
        style2.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);  
        style2.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);  
        style2.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);  
        style2.setAlignment(HSSFCellStyle.BORDER_MEDIUM); 
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
        
        
        
        
        
        //在sheet里创建第二行
        XSSFRow row2=sheet.createRow(1);
        
        //创建单元格并设置单元格内容
        XSSFCell createCell = row2.createCell(1);
        createCell.setCellStyle(style2);
        createCell.setCellValue("姓名");
        
        
        row2.createCell(2).setCellValue("班级");
        row2.createCell(3).setCellValue("笔试成绩");
        row2.createCell(4).setCellValue("机试成绩");
        //在sheet里创建第三行
        XSSFRow row3=sheet.createRow(2);
        row3.createCell(0).setCellValue("李明");
        row3.createCell(1).setCellValue("As178");
        row3.createCell(2).setCellValue(87);
        row3.createCell(3).setCellValue(78);

        try{
            OutputStream out = new FileOutputStream("E://a.xlsx");
            wb.write(out);
        }catch (Exception e){

        }

    }
}
