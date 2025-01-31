import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import './../library.dart';

class SampleInvoicePage extends StatefulWidget {
  const SampleInvoicePage({super.key});

  @override
  State<SampleInvoicePage> createState() => _SampleInvoicePageState();
}

class _SampleInvoicePageState extends State<SampleInvoicePage> {
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
          return pw.Container(
            padding: pw.EdgeInsets.all(20),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 2),  // Outer border
          ),
          child:
          pw.Column(
          children: [
            // Company Header
            pw.Text("SRI KUMARAN ENGINEERING WORKS",
                style: pw.TextStyle(
                    fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text("236, Periyakondalampatty, SALEM-636 610"),
            pw.Text("Cell: 98550 09963, 95295 55339"),
            pw.SizedBox(height: 10),

            // Invoice Details
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Consignee Name: __________________"),
                    pw.Text("Address: __________________"),
                    pw.Text("State: __________ State Code: ____"),
                    pw.Text("GSTIN No: __________________"),
                    pw.Text("PAN No: __________________"),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("PAN No.: CH5PST040H"),
                    pw.Text("GSTIN No.: 33CG5PST040H1ZY"),
                    pw.Text("Invoice No.: 68"),
                    pw.Text("Date: ______________"),
                    pw.Text("Vehicle No.: ______________"),
                    pw.Text("Transport: ______________"),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // Table Header
            pw.Table.fromTextArray(
              headers: ["S.No", "Description of Goods", "HSN/SAC", "GST Rate", "Qty.", "Rate", "Amount"],
              data: List.generate(
                10,
                (index) => [
                  "${index + 1}",
                  "Item $index",
                  "1234",
                  "18%",
                  "2",
                  "1000",
                  "2000"
                ],
              ),
              border: pw.TableBorder.all(),
              cellAlignment: pw.Alignment.center,
            ),
            pw.SizedBox(height: 10),

            // Total Calculation
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                pw.Text("Amount (in Words): ___________________"),
                pw.Text("___________________________________"),
                pw.Text("___________________________________"),
               ],
                ),
                pw.SizedBox(width: 5),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Amount Before Tax: ______"),
                    pw.Text("Add: CGST ___%: ______"),
                    pw.Text("Add: SGST ___%: ______"),
                    pw.Text("Add: IGST ___%: ______"),
                    pw.Text("Total Tax Amount: ______"),
                    pw.Text("Total Amount After Tax: ______"),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(5),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                  child: 
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [// Footer (Bank Details)
            pw.Text("Bank Details:"),
            pw.Text("Bank Name: KARUR VYSYA BANK"),
            pw.Text("A/c No.: 1785135000002886"),
            pw.Text("Branch: KONDALAMPATTY"),
            pw.Text("IFSC: KVBL0001785"),
            pw.SizedBox(height: 10),
              ],
            )),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text("For Sri Kumaran Engineering Works\nAuthorised Signatory"),
            ),
             ],
            ),
          ],
        ));
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
    // final output = await getTemporaryDirectory();
    // final file = File("${output.path}/invoice.pdf");
     
     Directory downloadsDir = Directory('/storage/emulated/0/Download');  // Android Downloads folder
     String filePath = '${downloadsDir.path}/invoice.pdf';
     File file = File(filePath);
   
    // Write the PDF to the file
    await file.writeAsBytes(await pdf.save());

    // Optionally, open the PDF file
    // If you're using the `printing` package, you can preview the PDF:
    // Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

    print('Invoice saved to: ${file.path}');
  }
}
