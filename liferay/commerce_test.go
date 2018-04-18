package liferay

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestDeployFolderCommerce(t *testing.T) {
	commerce := Commerce{}

	assert := assert.New(t)

	assert.Equal("/liferay/deploy", commerce.GetDeployFolder())
}

func TestGetFullyQualifiedNameCommerce(t *testing.T) {
	commerce := Commerce{Tag: "foo"}

	assert := assert.New(t)

	assert.Equal("liferay/liferay-commerce:foo", commerce.GetFullyQualifiedName())
}

func TestGetLiferayHomeCommerce(t *testing.T) {
	commerce := Commerce{}

	assert := assert.New(t)

	assert.Equal("/liferay", commerce.GetLiferayHome())
}

func TestGetCommercesRepository(t *testing.T) {
	commerce := Commerce{}

	assert := assert.New(t)
	commerceRepository := commerce.GetRepository()

	assert.Equal("liferay/liferay-commerce", commerceRepository)
}
