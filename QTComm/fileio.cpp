#include "fileio.h"

FileIO::FileIO()
{
}

bool FileIO::write(const QString& sourceUrl, const QString& data) {
    if (sourceUrl.isEmpty())
        return false;

    QUrl url(sourceUrl);
    QFile file(url.toLocalFile());
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;
    file.close();
    return true;
}

QByteArray FileIO::read(const QString& sourceUrl) {
    if (sourceUrl.isEmpty())
        return NULL;

    QUrl url(sourceUrl);
    QFile file(url.toLocalFile());
    if (!file.open(QFile::ReadOnly))
        return NULL;

    // NOTE: Has to be a QByteArray since we are only reading binary data
    QByteArray result = file.readAll();

    file.close();

    return result;
}
