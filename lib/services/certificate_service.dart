import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/certificate_model.dart';
import 'package:intl/intl.dart';

class CertificateService {
  Future<Uint8List> generateCertificatePdf(CertificateModel cert) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();
    final italicFont = await PdfGoogleFonts.notoSansItalic();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: const PdfColor.fromInt(0xFF4A6CF7),
                width: 4,
              ),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Header band
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(vertical: 10),
                  decoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFF4A6CF7),
                  ),
                  child: pw.Text(
                    'DS FUN LEARNING',
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: boldFont,
                      fontSize: 22,
                      color: PdfColors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                pw.SizedBox(height: 24),

                pw.Text(
                  'CERTIFICATE OF COMPLETION',
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 28,
                    color: const PdfColor.fromInt(0xFF4A6CF7),
                    letterSpacing: 2,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Divider(
                  color: const PdfColor.fromInt(0xFFFFCC00),
                  thickness: 2,
                ),
                pw.SizedBox(height: 16),

                pw.Text(
                  'This is to certify that',
                  style: pw.TextStyle(
                    font: italicFont,
                    fontSize: 14,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 12),

                pw.Text(
                  cert.userName,
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 36,
                    color: const PdfColor.fromInt(0xFF333333),
                  ),
                ),
                pw.SizedBox(height: 12),

                pw.Text(
                  'has successfully completed',
                  style: pw.TextStyle(
                    font: italicFont,
                    fontSize: 14,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 8),

                pw.Text(
                  '${cert.subjectEmoji}  ${cert.subjectName}',
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: 24,
                    color: const PdfColor.fromInt(0xFF4A6CF7),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  '${cert.className}  ·  ${cert.totalTopics} Topics',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 13,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 20),

                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 12),

                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Certificate ID',
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 9,
                            color: PdfColors.grey500,
                          ),
                        ),
                        pw.Text(
                          cert.id.substring(0, 16).toUpperCase(),
                          style: pw.TextStyle(font: boldFont, fontSize: 10),
                        ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          'Score',
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 9,
                            color: PdfColors.grey500,
                          ),
                        ),
                        pw.Text(
                          '${cert.score}%',
                          style: pw.TextStyle(
                            font: boldFont,
                            fontSize: 16,
                            color: const PdfColor.fromInt(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Date Issued',
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 9,
                            color: PdfColors.grey500,
                          ),
                        ),
                        pw.Text(
                          DateFormat('dd MMM yyyy').format(cert.issuedAt),
                          style: pw.TextStyle(font: boldFont, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> printCertificate(CertificateModel cert) async {
    final bytes = await generateCertificatePdf(cert);
    await Printing.layoutPdf(onLayout: (_) => bytes);
  }

  Future<void> shareCertificate(CertificateModel cert) async {
    final bytes = await generateCertificatePdf(cert);
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'DS_Certificate_${cert.subjectName}_${cert.userName}.pdf',
    );
  }
}
