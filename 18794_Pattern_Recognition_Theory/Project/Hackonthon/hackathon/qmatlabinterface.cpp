#include "qmatlabinterface.h"


QMatReal::QMatReal()
{
    row=0;
    col=0;
    mat=NULL;
}

QMatReal::QMatReal(unsigned int row, unsigned int col, QVector<double> matData)
{
    this->row=row;
    this->col=col;
    fillMat(matData);
}

QMatReal::~QMatReal()
{
    destroyMat();
}

void QMatReal::fillMat(QVector<double> matData)
{
    mat=mxCreateDoubleMatrix(row,col,mxREAL);
    unsigned int size=row*col;
    if(size!=matData.size())
    {
        matData.resize(size);
    }
    memcpy((void *)mxGetPr(mat),(void *)matData.data(),size*sizeof(double));
}

void QMatReal::fillMat(const mxArray *mat)
{
    row=mxGetM(mat);
    col=mxGetN(mat);
    this->mat=mxCreateDoubleMatrix(row,col,mxREAL);
    unsigned int size=row*col;
    memcpy((void *)mxGetPr(this->mat),(void *)mxGetPr(mat),size*sizeof(double));
}

void QMatReal::destroyMat()
{
    if(mat!=NULL)
    {
        mxDestroyArray(mat);
        row=0;
        col=0;
        mat=NULL;
    }
}

void QMatReal::setMatData(unsigned int row, unsigned int col, QVector<double> matData)
{
    destroyMat();
    this->row=row;
    this->col=col;
    fillMat(matData);
}

void QMatReal::setMat(const mxArray * mat)
{
    destroyMat();
    fillMat(mat);
}

void QMatReal::getMatData(unsigned int &row, unsigned int &col, QVector<double> &matData)
{
    if(isValid())
    {
        row=this->row;
        col=this->col;
        int size=row*col;
        matData.resize(size);
        memcpy((void *)matData.data(),(void *)mxGetPr(mat),size*sizeof(double));
    }
}

const mxArray *QMatReal::getMat()
{
    return mat;
}

bool QMatReal::isValid()
{
    return mat!=NULL;
}

QMatlabInterface::QMatlabInterface(QObject *parent) : QObject(parent)
{
    ep=engOpen(NULL);
    if(ep==NULL)
    {
        qFatal("Cannot Open Matlab Engine.");
    }
}

QMatlabInterface::~QMatlabInterface()
{
    if(ep!=NULL)
    {
        engClose(ep);
        ep=NULL;
    }
}

void QMatlabInterface::putMat(QString variable, QMatReal & matData)
{
    if(matData.isValid())
    {
        engPutVariable(ep,variable.toUtf8().data(),matData.getMat());
    }
    return;
}

void QMatlabInterface::putMat(QString variables, QString matFilename, QString desiredVariables)
{
    QString command;
    if(desiredVariables.isEmpty())
    {
        command=QString("%1=load(%2,'-mat');").arg(variables).arg(matFilename);

    }
    else
    {
        command=QString("%1=load(%2,'-mat',%3);").arg(variables).arg(matFilename).arg(desiredVariables);
    }
    engEvalString(ep,command.toUtf8().data());
    return;
}

void QMatlabInterface::getMat(QString variable, QMatReal &matData)
{
    mxArray * mat=engGetVariable(ep,variable.toUtf8().data());
    matData.setMat(mat);
    mxDestroyArray(mat);
}

void QMatlabInterface::runCommand(QString command)
{
    engEvalString(ep,command.toUtf8().data());
}

void QMatlabInterface::runScript(QString scriptFilename)
{
    QString command=QString("run(%1);").arg(scriptFilename);
    engEvalString(ep,scriptFilename.toUtf8().data());
    return;
}



