import 'package:flutter/material.dart';

import './../../../common/common.dart';

class OrderStatus extends StatelessWidget {
  final String status;
  final bool isOverdue;
  final Map<String, int> allStatus = <String, int>{
    'PENDING': 0,
    'REFUNDED': 1,
    'ACCEPTED': 2,
    'PREPARING_PURCHASE': 3,
    'SHIPPING': 4,
    'DELIVERED': 5,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatus({ Key? key, required this.status, required this.isOverdue }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(currentStatus == 0) ...[
          _StatusDot(isActive: true, title: 'Pedido pendente', backgroundColor: Colors.orange),
        ] else if(currentStatus == 1) ...[
          _StatusDot(isActive: true, title: 'Pix estornado', backgroundColor: Colors.orange),
        ] else if(isOverdue) ...[
          _StatusDot(isActive: true, title: 'Pagamento Pix vencido', backgroundColor: Colors.red,),
        ]  else ...[
          _StatusDot(isActive: true, title: 'Pedido confirmado', backgroundColor: Colors.green,),
          _CustomDivider(),          
          _StatusDot(isActive: currentStatus >= 2, title: 'Pagamento', backgroundColor: Colors.green ),
          _CustomDivider(),
          _StatusDot(isActive: currentStatus >= 3, title: 'Preparando', backgroundColor: Colors.green ),
          _CustomDivider(),
          _StatusDot(isActive: currentStatus >= 4, title: 'Envio', backgroundColor: Colors.green ),
          _CustomDivider(),
          _StatusDot(isActive: currentStatus == 5, title: 'Entregue', backgroundColor: Colors.green ),
        ] 
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;

  const _StatusDot({ Key? key, required this.isActive, required this.title, this.backgroundColor }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Row(
      children: [
        // Dot
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: primaryColor,
            ),
            color: isActive ? backgroundColor ?? primaryColor : Colors.transparent,
          ),
          child: isActive ? const Icon(Icons.check, size: 13, color: Colors.white,) : const SizedBox.shrink(),
        ),
        
        const SizedBox(width: 5,),
        
        Expanded(child: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: 
        TextStyle(
          fontSize: 12,
        ),)),
      ],
    );
  }
}