const { withIota, MutationAction, MutationVersion } = require('@1mill/with-iota')


exports.handler = (event, ctx) => {
	console.log("FIRING!!!!")
	console.log("FIRING!!!!")
	console.log({
		MutationAction,
		MutationVersion,
		withIota,
	})
	console.log("FIRING!!!!")
	console.log("FIRING!!!!")
	return { event, ctx }
}
