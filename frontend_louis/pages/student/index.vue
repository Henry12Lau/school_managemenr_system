<template>
    <v-row>
        <v-col>
            <v-sheet>
                <v-calendar ref="calendar" :events="events">
                    <template v-slot:event="{ event }">
                        <v-chip>
                            {{ formattedDateTime(event.start) }} - {{ event.title }}
                        </v-chip>
                    </template>
                </v-calendar>
            </v-sheet>
        </v-col>
    </v-row>
</template>

<script>
import { useDate } from 'vuetify'

export default {
    data: () => ({
        focus: '',
        events: [],
        names: ['Meeting', 'Holiday', 'PTO', 'Travel', 'Event', 'Birthday', 'Conference', 'Party'],
    }),
    mounted() {
        const adapter = useDate()
        this.fetchEvents({
            start: adapter.startOfDay(adapter.startOfMonth(new Date())),
            end: adapter.endOfDay(adapter.endOfMonth(new Date()))
        })
    },
    methods: {
        async fetchEvents({ start, end }) {
            try {
                this.loading = true;
                const userinfo = await $fetch(`${this.$config.public.apiBaseUrl}/auth/session`, {
                    method: 'POST',
                    credentials: 'include'
                });
                const { id, permission } = userinfo;
                // console.log(response)
                const response = await $fetch(`${this.$config.public.apiBaseUrl}/student/schedule`, {
                    method: 'POST',
                    body: {
                        id: id
                    },
                    credentials: 'include'
                });
                const self = this;
                this.events = [];
                const events = [];
                response.classes.forEach((item) => {
                    events.push({
                        title: item.subject_name,
                        start: self.convertDateToJS(item.lesson_start),
                        end: self.convertDateToJS(item.lesson_end),
                        allDay: false,
                    })
                });
                self.events = events;
                console.log(self.events);
            } catch (error) {
                console.log(error)

                // this.error = error.response.message || 'Invalid username or password';
                // this.errorMessage = true;
            } finally {
                this.loading = false;
            }
        },
        rnd(a, b) {
            return Math.floor((b - a + 1) * Math.random()) + a
        },
        formattedDateTime(dateTimeValue) {
            // return dateTimeValue.toString("HH:mm")
            const options = { hour: 'numeric', minute: 'numeric', hour12: true };
            return dateTimeValue.toLocaleTimeString('zh-HK', options);
        },
        convertDateToJS(date) {
            return new Date(date)
        },
    },
}
</script>