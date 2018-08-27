resource "aws_lb" "AppELB" {
  name               = "AppELB"
  security_groups    = ["${aws_security_group.LB_SG.id}"]
  subnets            = ["${aws_subnet.Public_subnet.*.id}"]
  internal           = false
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "AppTG" {
  name     = "ALBTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.My_Vpc.id}"
}

resource "aws_lb_target_group_attachment" "AppTGattach" {
  target_group_arn = "${aws_lb_target_group.AppTG.arn}"
  target_id        = "${element(aws_instance.my-instances.*.id, var.instance_count)}"
  port             = 80
}

resource "aws_lb_listener" "Apptglistener" {
  load_balancer_arn = "${aws_lb.AppELB.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.AppTG.arn}"
    type             = "forward"
  }
}
