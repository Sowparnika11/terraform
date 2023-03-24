module "secret"{
  source = "./code"
  region = "eu-west-2"
  secrets = {
	secret-1 = {
	description = "Another key/value secret"
	secret_key_value = {
		username = "user"
		password = "topsecret"
		}
	}
	}
  tags = {
	Name      = "sow-test"
}
}


