#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    interface=new QMatlabInterface(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QList<QString> Astr=ui->A->text().split(" ");
    QList<QString> Bstr=ui->B->text().split(" ");
    if(Astr.size()==Bstr.size())
    {
        unsigned int row=1;
        unsigned int col=Astr.size();
        QVector<double> Adata,Bdata;
        Adata.resize(col);
        Bdata.resize(col);
        for(int i=0;i<col;i++)
        {
            Adata[i]=Astr[i].toDouble();
            Bdata[i]=Bstr[i].toDouble();
        }
        QMatReal Amat(row,col,Adata);
        QMatReal Bmat(row,col,Bdata);
        interface->putMat("A",Amat);
        interface->putMat("B",Bmat);
        interface->runCommand("C=A+B");
        QMatReal Cmat;
        interface->getMat("C",Cmat);
        QVector<double> Cdata;
        Cmat.getMatData(row,col,Cdata);
        int size=row*col;
        QString Cstr="";
        for(int i=0;i<size;i++)
        {
            Cstr=Cstr+QString("%1 ").arg(Cdata[i]);
        }
        ui->C->setText(Cstr);
        interface->runCommand("plot(A,B);");
    }
}
