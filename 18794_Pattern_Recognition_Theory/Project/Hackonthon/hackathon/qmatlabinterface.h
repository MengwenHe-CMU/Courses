#ifndef QMATLABINTERFACE_H
#define QMATLABINTERFACE_H

#include <QObject>
#include <QVector>
#include <engine.h>

class QMatReal
{
public:
    QMatReal();
    QMatReal(unsigned int row, unsigned int col, QVector<double> matData);
    virtual ~QMatReal();
protected:
    unsigned int row,col;
    mxArray * mat;
protected:
    void fillMat(QVector<double> matData);
    void fillMat(const mxArray * mat);
    void destroyMat();
public:
    void setMatData(unsigned int row, unsigned int col, QVector<double> matData);
    void setMat(const mxArray * mat);
    void getMatData(unsigned int & row, unsigned int & col, QVector<double> & matData);
    const mxArray *getMat();
    bool isValid();
};

class QMatlabInterface : public QObject
{
    Q_OBJECT
public:
    explicit QMatlabInterface(QObject *parent = 0);
    ~QMatlabInterface();

protected:
    Engine * ep;

public:
    void putMat(QString variable, QMatReal & matData);
    void putMat(QString variables, QString matFilename, QString desiredVariables=QString());
    void getMat(QString variable, QMatReal & matData);
    void runCommand(QString command);
    void runScript(QString scriptFilename);
};

#endif // QMATLABINTERFACE_H
