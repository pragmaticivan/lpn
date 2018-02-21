package liferay

// Release implementation for Liferay released images
type Release struct {
	Tag string
}

// GetFullyQualifiedName returns the fully qualified name of the image
func (r Release) GetFullyQualifiedName() string {
	return r.GetRepository() + ":" + r.GetTag()
}

// GetLiferayHome returns the Liferay home for releases
func (r Release) GetLiferayHome() string {
	home := "liferay"

	if r.Tag == "7-ce-ga5-tomcat-hsql" {
		home = "liferay-ce-portal-7.0-ga5"
	} else if r.Tag == "7-ce-ga4-tomcat-hsql" {
		home = "liferay-ce-portal-7.0-ga4"
	} else if r.Tag == "7-ce-ga3-tomcat-hsql" {
		home = "liferay-ce-portal-7.0-ga3"
	} else if r.Tag == "7-ce-ga2-tomcat-hsql" {
		home = "liferay-ce-portal-7.0-ga2"
	} else if r.Tag == "7-ce-ga1-tomcat-hsql" {
		home = "liferay-ce-portal-7.0-ga1"
	} else if r.Tag == "6.2-ce-ga6-tomcat-hsql" {
		home = "liferay-portal-6.2-ce-ga1"
	} else if r.Tag == "6.1-ce-ga1-tomcat-hsql" {
		home = "liferay-portal-6.1.0-ce-ga1"
	}

	return "/usr/local/" + home
}

// GetRepository returns the repository for releases
func (r Release) GetRepository() string {
	return Releases
}

// GetTag returns the tag of the image
func (r Release) GetTag() string {
	return r.Tag
}