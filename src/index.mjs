import { withIota, MutationAction, MutationVersion } from '@1mill/with-iota'

const USERS_TABLE = 'users'

async function func({ data, findOne, mutation }) {
	const { name } = data

	if (!name) { throw new Error('name is required') }

	const user = await findOne(USERS_TABLE, { name })

	const { id } = user ?? mutation.stage({
		action: MutationAction.CREATE,
		props: { name },
		table: USERS_TABLE,
	})

	mutation.stage({
		action: MutationAction.SET,
		id,
		props: { updatedAt: new Date().toISOString() },
		table: USERS_TABLE,
	})

	return "HELLO WORLD!"
}

export function handler(event, ctx) {
	return withIota(event, ctx, { func })
}
