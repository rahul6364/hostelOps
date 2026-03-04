resource "aws_key_pair" "hostelops-key-pair" {
  key_name   = "hostelops-key"
  public_key = file("hostelops-key.pub")
}
resource "aws_security_group" "hostelops-sg" {
  name        = "hostelops-sg"
  description = "this is the sg of the hostelops instance"
  vpc_id      = module.vpc.vpc_id #interpolation

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow ssh"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allowed http"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_instance" "hostelops_instance" {
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  depends_on      = [aws_security_group.hostelops-sg, aws_key_pair.hostelops-key-pair]
  key_name        = aws_key_pair.hostelops-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.hostelops-sg.id]
  instance_type   = var.ec2_instance_type
  ami             = var.ec2_ami_id
  user_data       = file("hostelops.sh")
  root_block_device {
    volume_size = var.ec2_default_root_storage_size
    volume_type = "gp3"
  }
  tags = {
    Name = "hostelops-instance"
  }
}