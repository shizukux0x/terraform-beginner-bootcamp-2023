// package main: Declares the package name.
// The main package is special in Go, it's where the execution of the program starts.
package main

// import fmt Go library package, used for formatted I/O
import (
	"fmt"
	//"log"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)
// This defines a function `main` that prints a string
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// Format.PrintLine
	// Prints to standard output
	fmt.Println("Hello, world!")
}

// in golang, a titlecase function
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{
		},
		DataSourcesMap: map[string]*schema.Resource{
		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // marks the token as sensitive, hides it in logs
				Required: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

//func validateUUID(v interface{}, k string) (ws []string, errors []error) {
//	log.Print('validateUUID:start')
//	value := w.(string)
//	if _,err = uuid.Parse(value); err != mil {
//		errors = append(error, fmt.Errorf("invalid UUID format"))
//	}
//	log.Print('validateUUID:end')
//}
