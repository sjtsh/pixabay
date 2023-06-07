import 'package:flutter/material.dart';

class PButton extends StatefulWidget {
  final Widget? child;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? text;
  final double height;
  final double? width;
  final Function? onTap;
  final double radius;
  final Color? color;
  final Color? stroke;
  final Color? foreground;

  PButton(
      {this.child,
      this.prefixIcon,
      this.suffixIcon,
      this.text,
      this.height = 52,
      this.onTap,
      this.width,
      this.radius = 12,
      this.color,
      this.stroke,
      this.foreground});

  @override
  State<PButton> createState() => _PButtonState();
}

class _PButtonState extends State<PButton> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius));
    if (widget.stroke != null) {
      shape = RoundedRectangleBorder(
          side: BorderSide(color: widget.stroke!,width: 2),
          borderRadius: BorderRadius.circular(widget.radius));
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        color: widget.color ?? Theme.of(context).primaryColor,
      ),
      child: MaterialButton(
        height: widget.height,
        minWidth: widget.width ?? double.infinity,
        shape: shape,
        elevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        hoverElevation: 0,
        onPressed: () async {
          if (widget.onTap != null) {
            setState(() => disabled = true);
            await widget.onTap!();
            setState(() => disabled = false);
          }
        },
        child: Builder(builder: (context) {
          Color foreground = widget.foreground ?? const Color(0xffffffff);
          if (disabled) {
            return Center(
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: foreground)));
          }
          if (widget.child != null) return widget.child!;
          Text text = Text(
            widget.text ?? "todo",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: foreground, fontWeight: FontWeight.bold),
          );
          if (widget.prefixIcon == null && widget.suffixIcon == null) {
            return Center(child: text);
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.prefixIcon == null
                  ? Container()
                  : Icon(widget.prefixIcon!),
              text,
              widget.suffixIcon == null
                  ? Container()
                  : Icon(widget.suffixIcon!),
            ],
          );
        }),
      ),
    );
  }
}
