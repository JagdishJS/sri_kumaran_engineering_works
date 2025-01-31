import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import './../library.dart';

class SampleInvoicePage extends StatelessWidget {
  final String invoiceContent = "This is a very long invoice content...\n\n\n";
  // Add more content for a multi-page invoice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generate Invoice')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = await createInvoicePdf(invoiceContent);
            saveAndPreviewPdf(pdf);
          },
          child: Text('Generate Invoice'),
        ),
      ),
    );
  }

  Future<pw.Document> createInvoicePdf(String content) async {
    final pdf = pw.Document();

    // Helper function to add a header to every page
    pw.Widget header(pw.Context context) {
      return pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          'INVOICE',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
      );
    }

    // Helper function to add a footer to every page
    pw.Widget footer(pw.Context context) {
      return pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Text(
          'Page 1',
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey),
        ),
      );
    }

    // Add the first page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          // Add Header
          return pw.Column(
            children: [
              header(context), // Add header
              pw.SizedBox(height: 20), // Space between header and content
              pw.Text(content,
                  style: pw.TextStyle(fontSize: 16)), // Content text
              pw.SizedBox(height: 20), // Space between content and footer
              footer(context), // Add footer
            ],
          );
        },
      ),
    );

    // If content is too large for one page, add a second page
    if (content.length > 1000) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Add Header
            return pw.Column(
              children: [
                header(context), // Add header
                pw.SizedBox(height: 20), // Space between header and content
                pw.Text(content,
                    style: pw.TextStyle(fontSize: 16)), // Content text
                pw.SizedBox(height: 20), // Space between content and footer
                footer(context), // Add footer
              ],
            );
          },
        ),
      );
    }

    return pdf;
  }

  Future<void> saveAndPreviewPdf(pw.Document pdf) async {
    // Get temporary directory
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");

    // Write the PDF to the file
    await file.writeAsBytes(await pdf.save());

    // Optionally, open the PDF file
    // If you're using the `printing` package, you can preview the PDF:
    // Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

    print('Invoice saved to: ${file.path}');
  }
}
